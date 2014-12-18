

CREATE VIEW raw.vw_mp_mssp_dx_pivot

AS

SELECT cur_clm_uniq_id,
       diag1,
       diag2,
       diag3,
       diag4,
       diag5,
       diag6,
       diag7,
       diag8,
       diag9,
       diag10,
       diag11,
       diag12,
       diag13,
       diag14,
       diag15
FROM crosstab(
	'select cur_clm_uniq_id,
	       clm_val_sqnc_num,
	       CASE WHEN length(rtrim(clm_dgns_cd)) > 3 THEN LEFT(clm_dgns_cd,3)||''.''||right(RTRIM(clm_dgns_cd),2) 
	       ELSE rtrim(clm_dgns_cd)
	       END as clm_dgns_cd
	from raw.mp_partadxcdf4
	where CAST(clm_val_sqnc_num as integer) <= 15
	ORDER BY 1, 2',
	'select distinct clm_val_sqnc_num
	from raw.mp_partadxcdf4
	where CAST(clm_val_sqnc_num as integer) <= 15
	ORDER BY 1'
	)
	AS ct(cur_clm_uniq_id text, 
	      diag1 TEXT,
	      diag2 TEXT,
	      diag3 TEXT,
	      diag4 TEXT,
	      diag5 TEXT,
	      diag6 TEXT,
	      diag7 TEXT,
	      diag8 TEXT,
	      diag9 TEXT,
	      diag10 TEXT,
	      diag11 TEXT,
	      diag12 TEXT,
	      diag13 TEXT,
	      diag14 TEXT,
	      diag15 TEXT
	      )


