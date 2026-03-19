-- Task 1
-- Use an SQL query to extract information from the database for:
-- - students from annual EGE and OGE courses
--
-- The final output should include the following fields:
-- - Course ID
-- - Course name
-- - Subject
-- - Subject type
-- - Course type
-- - Course start date
-- - Student ID
-- - Student last name
-- - Student city
-- - Whether the student is not expelled from the course
-- - Course open date for the student
-- - Number of full course months available to the student
-- - Number of homework assignments submitted by the student in the course



-- Since we need student-level information, first join the `users` table with the `user_roles` table
-- to filter only users with the "student" role. We also need city information using a left join
-- so that students without city data are still kept in the result.

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

-- Create a CTE with course and subject information by joining `courses`, `course_types`, and `subjects`.
-- Filter course types to keep only annual courses, since the task asks for students from
-- annual EGE and OGE courses.

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

-- Join the `students_city` CTE with the `course_users` table to identify expelled students
-- Also add the date when access to the course was granted to each student.

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

-- To calculate the number of completed homework assignments per student per course,
-- join `homework_lessons` with lessons to get course information,
-- then join with `homework_done` to count completed homework assignments.
-- Homework is considered completed if it has a non-null mark.
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

-- We need to calculate the number of full course months available for a student.
-- The metric description is somewhat ambiguous: it is not fully clear whether it means
-- the number of months the student has already studied or the number of months remaining.
-- Based on the database schema, the only available way to derive this metric is
-- to divide available_lessons by lessons_in_month.
-- As interpreted from the schema, available_lessons appears to represent
-- the number of lessons still available to the student.
-- Therefore, this metric is treated as the number of remaining full months of study.
-- We use data from course_users and courses, divide available lessons by the number
-- of lessons per month for each student and course, and round the result because
-- the task asks for full months. Coalesce is used in case available_lessons is null,
-- and nullif prevents division by zero.

month_per_course as(
    select
        user_id,
        course_id,
        floor(coalesce(available_lessons, 0) / nullif(lessons_in_month, 0)) as available_months
    from course_users cu
    inner join courses c
        on c.id = cu.course_id
)

-- Combine all prepared data into the final result.

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
    coalesce(mc.available_months, 0) as available_months, -- use `coalesce` because some students may have no available months; replace null with 0
    coalesce(hd.cnt_hw_done_per_course, 0) as cnt_hw_done_per_course -- use `coalesce` because some students may not have completed any homework; replace null with 0
from active_stud_city acsc
inner join course_subj cs
    on cs.course_id = acsc.course_id
left join month_per_course mc  -- left join is used to keep students even if they have no available months
    on cs.course_id = mc.course_id and mc.user_id = acsc.student_id -- join by both student and course to ensure correct matching
left join hw_done hd -- left join is used to keep students who have not submitted any homework
    on hd.user_id = acsc.student_id and hd.course_id = cs.course_id -- join by both student and course to ensure correct matching