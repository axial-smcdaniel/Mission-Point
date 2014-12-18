CREATE VIEW raw.vw_mp_partaheader_clean

AS


select  DISTINCT 
	cur_clm_uniq_id,
	f1.provdr_oscar_num,
	bene_hic_num,
	clm_type_cd,
	f1.clm_from_dt,
	f1.clm_thru_dt,
	clm_bill_fac_type_cd,
	clm_bill_clsfctn_cd,
	prncpl_dgns_cd,
	admtg_dgns_cd,
	clm_mdcr_npmt_rsn_cd,
	clm_pmt_amt,
	clm_nch_prmry_pyr_cd,
	prvdr_fac_fips_st_cd,
	bene_ptnt_stus_cd,
	dgns_drg_cd,
	clm_op_srvc_type_cd,
	fac_prvdr_npi_num,
	oprtg_prvdr_npi_num,
	atndg_prvdr_npi_num,
	othr_provdr_npi_num,
	clm_adjsmt_type_cd,
	clm_effctv_dt,
	clm_idr_ld_dt,
	f1.bene_eqtbl_bic_hicn_num,
	clm_admsn_type_cd,
	clm_admsn_src_cd,
	clms_bill_freq_cd,
	clm_query_cd
from raw.mp_partaheaderf1 f1
JOIN raw.vw_mp_partaheader_deduped c on f1.cur_clm_uniq_id = c.dr_cur_clm_uniq_id
where  clm_pmt_amt > 0
order by 2,3,5,6