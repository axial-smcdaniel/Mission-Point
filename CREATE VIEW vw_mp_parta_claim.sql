SELECT  hdr.cur_clm_uniq_id,
	provdr_oscar_num,
	hdr.bene_hic_num,
	hdr.clm_type_cd,
	hdr.clm_from_dt,
	hdr.clm_thru_dt,
	clm_bill_fac_type_cd,
	clm_bill_clsfctn_cd,
	prncpl_dgns_cd,
	admtg_dgns_cd,
	clm_mdcr_npmt_rsn_cd,
	CASE WHEN clm_adjsmt_type_cd = '1 ' THEN -clm_pmt_amt
	     ELSE clm_pmt_amt
	END as clm_pmt_amt,
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
	hdr.bene_eqtbl_bic_hicn_num,
	clm_admsn_type_cd,
	clm_admsn_src_cd,
	clms_bill_freq_cd,
	clm_query_cd,
--dtl-------------
	clm_line_num,
	dtl.bene_hic_num,
	dtl.clm_type_cd,
	clm_line_from_dt,
	clm_line_thru_date,
	clm_line_prod_rev_ctr_cd,
	clm_line_instnl_rev_ctr_dt,
	clm_line_hcpcs_cd,
	dtl.bene_eqtbl_bic_hicn_num,
	prvdr_oscar_num,
	dtl.clm_from_dt,
	dtl.clm_thru_dt,
	CASE WHEN clm_adjsmt_type_cd = '1 ' THEN -clm_line_srvc_unit_qty
	     ELSE clm_line_srvc_unit_qty
	END clm_line_srvc_unit_qty,
	CASE WHEN clm_adjsmt_type_cd = '1 ' THEN -clm_line_cvrd_pd_amt
	     ELSE clm_line_cvrd_pd_amt
	END as clm_line_crvd_pd_amt,
	hcpcs_1_mdfr_cd,
	hcpcs_2_mdfr_cd,
	hcpcs_3_mdfr_cd,
	hcpcs_4_mdfr_cd,
	hcpcs_5_mdfr_cd,
----dx---------
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
	diag15,
----proc-----------
	proc1,
	procdate1,
	proc2,
	procdate2,
	proc3,
	procdate3,
	proc4,
	procdate4,
	proc5,
	procdate5,
	proc6,
	procdate6,
	proc7,
	procdate7,
	proc8,
	procdate8,
	proc9,
	procdate9,
	proc10,
	procdate10,
	proc11,
	procdate11,
	proc12,
	procdate12,
	proc13,
	procdate13,
	proc14,
	procdate14,
	proc15,
	procdate15
FROM raw.mp_partaheaderf1 hdr
LEFT JOIN raw.mp_partarevcenterf2 dtl on hdr.cur_clm_uniq_id = dtl.cur_clm_uniq_id
LEFT JOIN mp_mssp_proc_pivot pr on hdr.cur_clm_uniq_id = pr.cur_clm_uniq_id
LEFT JOIN mp_mssp_procdate_pivot pr1 ON hdr.cur_clm_uniq_id = pr1.cur_clm_uniq_id
LEFT JOIN raw.vw_mp_mssp_dx_pivot dx on hdr.cur_clm_uniq_id = dx.cur_clm_uniq_id
WHERE hdr.cur_clm_uniq_id IN('0036945909667','0037067375351','0037176965209')
ORDER BY hdr.cur_clm_uniq_id, dtl.clm_line_num

--debit, credit, debit - dollars the same IN('0036843024391', '0036923825897','0036923825896')
--debit, credit, original - dollars different IN('0036945909667','0037067375351','0037176965209')


