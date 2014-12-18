-- View: vw_mp_rx_claims_2013

-- DROP VIEW vw_mp_rx_claims_2013;

CREATE OR REPLACE VIEW vw_mp_rx_claims_2013 AS 
 SELECT x.axial_member_id,
    date_part('month'::text, rqx.date_of_fill) AS service_from_month,
    date_part('year'::text, rqx.date_of_fill) AS service_from_year,
    date_part('day'::text, rqx.date_of_fill) AS service_from_day,
    rqx.date_of_fill AS service_from_date,
    rqx.date_of_fill + rqx.days_supply::integer - 1 AS service_to_date,
    date_part('month'::text, rqx.date_of_fill + rqx.days_supply::integer - 1) AS service_to_month,
    date_part('year'::text, rqx.date_of_fill + rqx.days_supply::integer - 1) AS service_to_year,
    date_part('day'::text, rqx.date_of_fill + rqx.days_supply::integer - 1) AS service_to_day,
    REPLACE(rqx.ndc,'-','')::character varying(20) as ndc,
    rqx.claim_identifier,
    rqx.days_supply,
    rqx.quantity AS units,
    rqx.total_cost AS amount_allowed,
    rqx.amt_paid AS amount_paid,
    rqx.total_member_out_of_pocket,
    rqx.deductible_amt AS amount_deductible,
    rqx.coinsurance_amount AS amount_coinsurance,
    rqx.prescriber_npi,
    rqx.prescriber_name,
    npt.provider_type AS prescriber_type,
    npt.provider_class AS prescriber_class,
    npt.provider_specialty AS prescriber_specialty,
    npn.entity_type_code,
    npn.provider_last_name_legal_name AS prescriber_last,
    npn.provider_first_name AS prescriber_first,
    npn.provider_middle_name AS prescriber_middle,
    npac.provider_first_line_business_practice_location_address AS prescriber_address1,
    npac.provider_second_line_business_practice_location_address AS prescriber_address2,
    npac.provider_business_practice_location_address_city_name AS prescriber_city,
    npac.provider_business_practice_location_address_state_name AS prescriber_state,
    npac.provider_business_practice_location_address_postal_code AS prescriber_zip,
    zhh.hsanum,
    zhh.hsacity,
    zhh.hsastate,
    zhh.hrrnum,
    zhh.hrrcity,
    zhh.hrrstate,
    rqx.pharmacy_name,
    mcder_drugs_w_med.strength,
    mcder_drugs_w_med.conversion_factor,
    mcder_drugs_w_med.med,
    mcder_drugs_w_med.med * rqx.quantity / rqx.days_supply AS daily_med_dose_equivalent,
    mcder_drugs_w_med.producttypename,
    mcder_drugs_w_med.proprietaryname,
    mcder_drugs_w_med.substancename,
    mcder_drugs_w_med.strengthnumber,
    mcder_drugs_w_med.strengthunit,
    mcder_drugs_w_med.pharm_classes,
    rqx.sourcefile,
    rqx.loaddate
   FROM raw.mp_rx_claims_2013 rqx
     LEFT JOIN dev.mcder_drugs_w_med ON mcder_drugs_w_med.ndc_11::text = REPLACE(rqx.ndc,'-','')::text
     LEFT JOIN non_hipaa.mp_member_id_xwalk x ON x.mp_healthplanid::text = rqx.member_id::text
     LEFT JOIN dev.npi_primary_taxonomy npt ON rqx.prescriber_npi::text = npt.npi::character varying(20)::text
     LEFT JOIN dev.npi_provider_name npn ON rqx.prescriber_npi::text = npn.npi::character varying(20)::text
     LEFT JOIN dev.npi_provider_address npac ON rqx.prescriber_npi::text = npac.npi::character varying(20)::text
     LEFT JOIN dev.zip_hsa_hrr zhh ON npac.provider_business_practice_location_address_postal_code::text = zhh.zipcode::text
  WHERE rqx.days_supply > 0::numeric AND rqx.status_code::text = 'APPROVED'::text
  ORDER BY x.axial_member_id, rqx.date_of_fill

