# This Python script simulates a database query
# Write your SQL query into the `query` variable and run this script to get the result
# Before running the script, install the duckdb library

# Install the duckdb library
# pip install duckdb duckdb-engine

# Import libraries
import duckdb
import pandas as pd

# Load database tables
users = pd.read_csv("data/users.csv")
course_users = pd.read_csv("data/course_users.csv")
courses = pd.read_csv("data/courses.csv")
course_types = pd.read_csv("data/course_types.csv")
lessons = pd.read_csv("data/lessons.csv")
subjects = pd.read_csv("data/subjects.csv")
cities = pd.read_csv("data/cities.csv")
homework_done = pd.read_csv("data/homework_done.csv")
homework = pd.read_csv("data/homework.csv")
homework_lessons = pd.read_csv("data/homework_lessons.csv")
user_roles = pd.read_csv("data/user_roles.csv")

# Define your SQL query
query = """
with students_city as(
    select
        u.id as student_id,
        u.last_name as student_last_name,
        c.name as city
    from users u
    inner join user_roles ur
        on u.user_role_id = ur.id
    left join cities c
        on c.id = u.city_id
    where ur.name = 'student'
),


course_subj as(
    select
        c.id as course_id,
        c.name as course_name,
        ct.name as course_type,
        c.starts_at as course_start_date,
        s.name as subject_name, 
        s.project as subject_type
    from course_types ct
    inner join courses c
        on c.course_type_id = ct.id
    inner join subjects s
        on c.subject_id = s.id
    where ct.name like 'Annual%'
    
),

 active_stud_city as(
    select
        sc.*,
        cu.course_id,
        case
            when cu.active = 1 then 0
            else 1
        end as is_expelled,
        cu.created_at as student_start_date
    from students_city sc
    inner join course_users cu
        on sc.student_id = cu.user_id
),


hw_done as(
    select
        hwd.user_id,
        l.course_id,
        count(distinct hwd.homework_id) as cnt_hw_done_per_course
    from lessons l
    inner join homework_lessons hwl
        on l.id = hwl.lesson_id
    inner join homework_done hwd
        on hwl.homework_id = hwd.homework_id
where hwd.mark is not null
    group by user_id, course_id
),

month_per_course as(
    select
        user_id,
        course_id,
        floor(coalesce(available_lessons, 0) / nullif(lessons_in_month, 0)) as available_months
    from course_users cu
    inner join courses c
        on c.id = cu.course_id
)
select
    cs.course_id,
    cs.course_name,
    cs.subject_name, 
    cs.subject_type,
    cs.course_type,
    cs.course_start_date,
    acsc.student_id,
    acsc.student_last_name,
    acsc.city,
    acsc.is_expelled,
    acsc.student_start_date,
    coalesce(mc.available_months, 0) as available_months,
    coalesce(hd.cnt_hw_done_per_course, 0) as cnt_hw_done_per_course
from active_stud_city acsc
inner join course_subj cs
    on cs.course_id = acsc.course_id
left join month_per_course mc 
    on cs.course_id = mc.course_id and mc.user_id = acsc.student_id
left join hw_done hd
    on hd.user_id = acsc.student_id and hd.course_id = cs.course_id 
"""

# Execute the SQL query
df_result = duckdb.query(query).to_df()

df_result.to_excel("task1_output.xlsx", index=False)

# Print the result
print(df_result)
