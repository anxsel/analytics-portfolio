https://datalens.yandex/prx3rzg4f7vq9

To calculate the number of renewals, the field `renewed = (case [is_expelled] when 0 then 1 else 0 END)` was created, and the sum for this field was calculated. This yielded the number of renewals.

To calculate the percentage of renewals, the field `renews_perc = (sum([renewed]) / count([student_id])) * 100` was created.

To track the number and percentage of renewals for a given month, a selector was set for the `available_months` field in the dashboard.

To create a "Month prologation Status" filter for students who did not renew a given month of the course, the `renew_month` parameter was created, along with the field `renew_status = (if [available_months] > [renew_month] then 'prolonged' else 'not prolonged' end)` in the dataset.