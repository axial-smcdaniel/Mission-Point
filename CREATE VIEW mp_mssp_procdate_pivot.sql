CREATE VIEW raw.mp_mssp_procdate_pivot

AS

SELECT cur_clm_uniq_id,
       procdate1,
       procdate2,
       procdate3,
       procdate4,
       procdate5,
       procdate6,
       procdate7,
       procdate8,
       procdate9,
       procdate10,
       procdate11,
       procdate12,
       procdate13,
       procdate14,
       procdate15
FROM crosstab(
	'select cur_clm_uniq_id,
	       clm_val_sqnc_num,
	       clm_prcdr_prfrm_dt
	from raw.mp_partaproccodef3
	where CAST(clm_val_sqnc_num as integer) <= 15
	ORDER BY 1, 2',
	'select distinct clm_val_sqnc_num
	from raw.mp_partaproccodef3
	where CAST(clm_val_sqnc_num as integer) <= 15
	ORDER BY 1'
	)
	AS ct(cur_clm_uniq_id text, 
	      procdate1 date,
	      procdate2 date,
	      procdate3 date,
	      procdate4 date,
	      procdate5 date,
	      procdate6 date,
	      procdate7 date,
	      procdate8 date,
	      procdate9 date,
	      procdate10 date,
	      procdate11 date,
	      procdate12 date,
	      procdate13 date,
	      procdate14 date,
	      procdate15 date
	      )

	      