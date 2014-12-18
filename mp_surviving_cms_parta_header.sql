WITH cte AS
(SELECT c.*,
        CASE WHEN RTRIM(clm_adjsmt_type_cd) = '1' THEN -1 else 1 end DrCr--, rn as rn2
        --row_number() OVER (PARTITION BY provdr_oscar_num,
        --bene_eqtbl_bic_hicn_num,
        --clm_from_dt,
        --clm_thru_dt
       -- ORDER BY clm_adjsmt_type_cd) as rn2
--SELECT * 
 FROM raw.temp_mp_partaheader_dup c)
 SELECT provdr_oscar_num,
        bene_eqtbl_bic_hicn_num,
        clm_from_dt,
        clm_thru_dt,
        max(case DrCr when 1 THEN cur_clm_uniq_id END) Dr_cur_clm_uniq_id,
        SUM(CASE DrCr WHEN 1 THEN clm_pmt_amt ELsE 0 END) DrAmount,
        max(case DrCr WHEN 1 THEN clm_adjsmt_type_cd END) DrAdjustmentFlag,
        max(case DrCr when -1 THEN cur_clm_uniq_id END) Cr_cur_clm_uniq_id,
        SUM(CASE DrCr WHEN -1 THEN clm_pmt_amt ELsE 0 END) CrAmount,
        max(case DrCr WHEN -1 THEN clm_adjsmt_type_cd END) CrAdjustmentFlag,
        SUM(DrCr * clm_pmt_amt) BalanceAmount
 FROM cte
 GROUP BY provdr_oscar_num,
        bene_eqtbl_bic_hicn_num,
        clm_from_dt,
        clm_thru_dt--,
        --rn2
 HAVING SUM(DrCr * clm_pmt_amt) > 0
 ORDER BY 1,2,3,4