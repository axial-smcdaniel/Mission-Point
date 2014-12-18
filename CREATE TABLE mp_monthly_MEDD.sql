--drop table IF EXISTS public.mp_monthly_medd

CREATE VIEW public.mp_monthly_medd

AS


SELECT  axial_member_id,
	ROUND(SUM(MEDD)) MEDD_total,
        CAST(DATE_TRUNC('month', rx_date) as DATE) mon_start,
        COUNT(DISTINCT rx_date) rx_days,
        DATE_PART('days', DATE_TRUNC('month', rx_date) + '1 month'::INTERVAL - DATE_TRUNC('month', rx_date)) as mo_days,
        CASE WHEN COUNT(DISTINCT rx_date) < DATE_PART('days', DATE_TRUNC('month', rx_date) + '1 month'::INTERVAL - DATE_TRUNC('month', rx_date))
             THEN ROUND(SUM(MEDD)/COUNT(DISTINCT rx_date),2)
             ELSE ROUND(SUM(MEDD)/CAST(DATE_PART('days', DATE_TRUNC('month', rx_date) + '1 month'::INTERVAL - DATE_TRUNC('month', rx_date)) as numeric),2) 
             END AS MEDD
FROM (
	SELECT axial_member_id,
	       ROUND(daily_med_dose_equivalent) MEDD,
	       CAST(generate_series(service_from_date, service_to_date, '1 day'::INTERVAL) as DAte) as rx_date
	FROM vw_mp_combined_rx_claims rx
	where rx.pharm_classes like '%pioid%'
       ) my
GROUP BY axial_member_id,
         DATE_TRUNC('month', rx_date),
         DATE_PART('days', DATE_TRUNC('month', rx_date) + '1 month'::INTERVAL - DATE_TRUNC('month', rx_date))