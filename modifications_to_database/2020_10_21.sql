-- Modifications based on http://localhost:8888/notebooks/DataShare/dhdt_projects/test_area/8_Mike_training_time_series/time_series_test.ipynb

-- 1. DataFrame (.info)
-- birth_year shows as 'float' s/be 'int64'. Possible negative birth year in dataset?

-- age_first_year shows as 'float' s/be 'int64.' Possible removed when birth_year cleaned?

-- Data cleaning of records required:

-
--person_id	years_member
--1258	-1
--1266	-1
--1519	-1
--590	-1
--1355	-1
--1725	-1
--1895	-1680
--643	-2
--746	-7
--1160	-7
--1266	-1
--1483	-1
--1740	-2
--1991	-1
--2024	-1
--2447	-21

--1258	-1
Select *
From vw_ceda_membership_gephi vcmg 
Where id = 1258;

Update m2m_person_ceda 
Set first_year ='1862'
Where person_id = 1258;


--1266	-1
Select *
From vw_ceda_membership_gephi vcmg 
Where id = 1266;

Update m2m_person_ceda 
Set first_year ='1869'
Where person_id = 1266;

--1519	-1
Select *
From vw_ceda_membership_gephi vcmg 
Where id = 1519;

Update m2m_person_ceda 
Set first_year ='1868'
Where person_id = 1519 AND first_year = '1870';

--590	-1
Select *
From vw_ceda_membership_gephi vcmg 
Where id = 590;

Update m2m_person_ceda 
Set first_year ='1865'
Where person_id = 590;

--1355	-1
Select *
From vw_ceda_membership_gephi vcmg 
Where id = 1355;

Update m2m_person_ceda 
Set first_year ='1864'
Where person_id = 1355;

--1725	-1
Select *
From vw_ceda_membership_gephi vcmg 
Where id = 1725;

Update m2m_person_ceda 
Set first_year ='1865'
Where person_id = 1725 AND first_year = '1866';

--1895	-1680
Select *
From vw_ceda_membership_gephi vcmg 
Where id = 1895;

Update m2m_person_ceda 
Set last_year ='1866'
Where person_id = 1895;

--643	-2
Select *
From vw_ceda_membership_gephi vcmg 
Where id = 643;

Update m2m_person_ceda 
Set first_year ='1868'
Where person_id = 643 AND first_year = '1870';

--746	-7
Select *
From vw_ceda_membership_gephi vcmg 
Where id = 746;

Update m2m_person_ceda 
Set first_year ='1863'
Where person_id = 746;

--1160	-7
Select *
From vw_ceda_membership_gephi vcmg 
Where id = 1160;

Update m2m_person_ceda 
Set first_year ='1844'
Where person_id = 1160;

--1266	-1
Select *
From vw_ceda_membership_gephi vcmg 
Where id = 1266;

Update m2m_person_ceda 
Set first_year ='1869'
Where person_id = 1266;

Update m2m_person_ceda 
Set last_year ='1869'
Where person_id = 1266;

--1483	-1
Select *
From vw_ceda_membership_gephi vcmg 
Where id = 1483;

Update m2m_person_ceda 
Set first_year ='1869'
Where person_id = 1483 AND first_year = '1870';

--1740	-2
Select *
From vw_ceda_membership_gephi vcmg 
Where id = 1740;

Update m2m_person_ceda 
Set first_year ='1866'
Where person_id = 1740 AND first_year = '1871';

--1991	-1
Select *
From vw_ceda_membership_gephi vcmg 
Where id = 1991;

Update m2m_person_ceda 
Set first_year ='1868'
Where person_id = 1991 AND first_year = '1871';

--2024	-1
Select *
From vw_ceda_membership_gephi vcmg 
Where id = 2024;

Update m2m_person_ceda 
Set first_year ='1866'
Where person_id = 2024 AND first_year = '1871';

--2447	-21
Select *
From vw_ceda_membership_gephi vcmg 
Where id = 2447;

Update m2m_person_ceda 
Set last_year ='1861'
Where person_id = 2447;

-- 1949 remove comma at end of death_year
Select *
From person
Where id = 1945;

Update person 
Set death_year ='1902'
Where id = 1945;


--END

