-- Создайте отчет, который покажет сумму продаж с учётом списания бонусов за каждый месяц 2022 года по картам, начинающимся с 2000 и накопительный итог с начала года.

-- Требования к отчету:

-- month_number — номер месяца (1-12)
-- month_name — название месяца на английском языке
-- monthly_sales — общая сумма продаж за месяц с учётом списания бонусов (summ_with_disc)
-- cumulative_sales — накопительная сумма продаж с начала года
-- Результат отсортируйте по возрастанию номера месяца.

select 
    month_number,
    month_name,
    monthly_sales,
    CAST(SUM(monthly_sales) OVER (
        ORDER BY month_number
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS UNSIGNED) as cumulative_sales
from (
    select 
        MONTH(datetime) as month_number,
        MONTHNAME(datetime) as month_name,
        CAST(SUM(summ_with_disc) AS UNSIGNED) as monthly_sales
    from checks
    where left(card, 4) = '2000' and YEAR(datetime) = '2022'
    group by month_number, month_name
) as t
order by month_number;
