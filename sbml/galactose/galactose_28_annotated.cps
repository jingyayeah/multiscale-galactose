<?xml version="1.0" encoding="UTF-8"?>
<!-- generated with COPASI 4.16 (Build 104) (http://www.copasi.org) at 2015-12-05 10:04:50 UTC -->
<?oxygen RNGSchema="http://www.copasi.org/static/schema/CopasiML.rng" type="xml"?>
<COPASI xmlns="http://www.copasi.org/static/schema" versionMajor="4" versionMinor="16" versionDevel="104" copasiSourcesModified="0">
  <ListOfFunctions>
    <Function key="Function_47" name="Function for Galactokinase [c__]" type="UserDefined" reversible="unspecified">
      <Expression>
        (c__gal/c__gal_tot*c__GALK_Vf-c__gal1p/c__gal1p_tot*c__GALK_Vb)/c
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_350" name="c" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_351" name="c__GALK_Vb" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_352" name="c__GALK_Vf" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_353" name="c__gal" order="3" role="substrate"/>
        <ParameterDescription key="FunctionParameter_354" name="c__gal1p" order="4" role="product"/>
        <ParameterDescription key="FunctionParameter_355" name="c__gal1p_tot" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_356" name="c__gal_tot" order="6" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_48" name="Function for Galactokinase M [c__]" type="UserDefined" reversible="unspecified">
      <Expression>
        (c__galM/c__gal_tot*c__GALK_Vf-c__gal1pM/c__gal1p_tot*c__GALK_Vb)/c
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_364" name="c" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_365" name="c__GALK_Vb" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_366" name="c__GALK_Vf" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_367" name="c__gal1pM" order="3" role="product"/>
        <ParameterDescription key="FunctionParameter_368" name="c__gal1p_tot" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_369" name="c__galM" order="5" role="substrate"/>
        <ParameterDescription key="FunctionParameter_370" name="c__gal_tot" order="6" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_49" name="Function for Inositol monophosphatase [c__]" type="UserDefined" reversible="unspecified">
      <Expression>
        c__gal1p/c__gal1p_tot*c__IMP_Vf/c
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_346" name="c" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_348" name="c__IMP_Vf" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_349" name="c__gal1p" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_378" name="c__gal1p_tot" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_50" name="Function for Inositol monophosphatase M [c__]" type="UserDefined" reversible="unspecified">
      <Expression>
        c__gal1pM/c__gal1p_tot*c__IMP_Vf/c
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_383" name="c" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_384" name="c__IMP_Vf" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_385" name="c__gal1pM" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_386" name="c__gal1p_tot" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_51" name="Function for ATP synthase [c__]" type="UserDefined" reversible="unspecified">
      <Expression>
        c__ATPS_Vmax/(ATPS_k_adp*ATPS_k_phos)*(c__adp*c__phos-c__atp/ATPS_keq)/((1+c__adp/ATPS_k_adp)*(1+c__phos/ATPS_k_phos)+c__atp/ATPS_k_atp)/c
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_396" name="ATPS_k_adp" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_397" name="ATPS_k_atp" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_398" name="ATPS_k_phos" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_399" name="ATPS_keq" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_400" name="c" order="4" role="volume"/>
        <ParameterDescription key="FunctionParameter_401" name="c__ATPS_Vmax" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_402" name="c__adp" order="6" role="substrate"/>
        <ParameterDescription key="FunctionParameter_403" name="c__atp" order="7" role="product"/>
        <ParameterDescription key="FunctionParameter_404" name="c__phos" order="8" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_52" name="Function for Aldose reductase [c__]" type="UserDefined" reversible="unspecified">
      <Expression>
        (c__gal/c__gal_tot*c__ALDR_Vf-c__galtol/c__galtol_tot*c__ALDR_Vb)/c
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_394" name="c" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_258" name="c__ALDR_Vb" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_414" name="c__ALDR_Vf" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_415" name="c__gal" order="3" role="substrate"/>
        <ParameterDescription key="FunctionParameter_416" name="c__gal_tot" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_417" name="c__galtol" order="5" role="product"/>
        <ParameterDescription key="FunctionParameter_418" name="c__galtol_tot" order="6" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_53" name="Function for Aldose reductase M [c__]" type="UserDefined" reversible="unspecified">
      <Expression>
        (c__galM/c__gal_tot*c__ALDR_Vf-c__galtolM/c__galtol_tot*c__ALDR_Vb)/c
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_426" name="c" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_427" name="c__ALDR_Vb" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_428" name="c__ALDR_Vf" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_429" name="c__galM" order="3" role="substrate"/>
        <ParameterDescription key="FunctionParameter_430" name="c__gal_tot" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_431" name="c__galtolM" order="5" role="product"/>
        <ParameterDescription key="FunctionParameter_432" name="c__galtol_tot" order="6" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_54" name="Function for NADP Reductase [c__]" type="UserDefined" reversible="unspecified">
      <Expression>
        c__NADPR_Vmax/NADPR_k_nadp*(c__nadp-c__nadph/NADPR_keq)/(1+c__nadp/NADPR_k_nadp+c__nadph/NADPR_ki_nadph)/c
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_440" name="NADPR_k_nadp" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_441" name="NADPR_keq" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_442" name="NADPR_ki_nadph" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_443" name="c" order="3" role="volume"/>
        <ParameterDescription key="FunctionParameter_444" name="c__NADPR_Vmax" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_445" name="c__nadp" order="5" role="substrate"/>
        <ParameterDescription key="FunctionParameter_446" name="c__nadph" order="6" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_55" name="Function for Galactose-1-phosphate uridyl transferase [c__]" type="UserDefined" reversible="true">
      <Expression>
        (c__gal1p/c__gal1p_tot*c__udpglc/c__udpglc_tot*c__GALT_Vf-c__glc1p/c__glc1p_tot*c__udpgal/c__udpgal_tot*c__GALT_Vb)/c
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_458" name="c" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_459" name="c__GALT_Vb" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_460" name="c__GALT_Vf" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_461" name="c__gal1p" order="3" role="substrate"/>
        <ParameterDescription key="FunctionParameter_462" name="c__gal1p_tot" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_463" name="c__glc1p" order="5" role="product"/>
        <ParameterDescription key="FunctionParameter_464" name="c__glc1p_tot" order="6" role="constant"/>
        <ParameterDescription key="FunctionParameter_465" name="c__udpgal" order="7" role="product"/>
        <ParameterDescription key="FunctionParameter_466" name="c__udpgal_tot" order="8" role="constant"/>
        <ParameterDescription key="FunctionParameter_467" name="c__udpglc" order="9" role="substrate"/>
        <ParameterDescription key="FunctionParameter_468" name="c__udpglc_tot" order="10" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_56" name="Function for Galactose-1-phosphate uridyl transferase M1 [c__]" type="UserDefined" reversible="true">
      <Expression>
        (c__gal1pM/c__gal1p_tot*c__udpglc/c__udpglc_tot*c__GALT_Vf-c__glc1p/c__glc1p_tot*c__udpgalM/c__udpgal_tot*c__GALT_Vb)/c
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_480" name="c" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_481" name="c__GALT_Vb" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_482" name="c__GALT_Vf" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_483" name="c__gal1pM" order="3" role="substrate"/>
        <ParameterDescription key="FunctionParameter_484" name="c__gal1p_tot" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_485" name="c__glc1p" order="5" role="product"/>
        <ParameterDescription key="FunctionParameter_486" name="c__glc1p_tot" order="6" role="constant"/>
        <ParameterDescription key="FunctionParameter_487" name="c__udpgalM" order="7" role="product"/>
        <ParameterDescription key="FunctionParameter_488" name="c__udpgal_tot" order="8" role="constant"/>
        <ParameterDescription key="FunctionParameter_489" name="c__udpglc" order="9" role="substrate"/>
        <ParameterDescription key="FunctionParameter_490" name="c__udpglc_tot" order="10" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_57" name="Function for Galactose-1-phosphate uridyl transferase M2 [c__]" type="UserDefined" reversible="true">
      <Expression>
        (c__gal1p/c__gal1p_tot*c__udpglcM/c__udpglc_tot*c__GALT_Vf-c__glc1pM/c__glc1p_tot*c__udpgal/c__udpgal_tot*c__GALT_Vb)/c
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_502" name="c" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_503" name="c__GALT_Vb" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_504" name="c__GALT_Vf" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_505" name="c__gal1p" order="3" role="substrate"/>
        <ParameterDescription key="FunctionParameter_506" name="c__gal1p_tot" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_507" name="c__glc1pM" order="5" role="product"/>
        <ParameterDescription key="FunctionParameter_508" name="c__glc1p_tot" order="6" role="constant"/>
        <ParameterDescription key="FunctionParameter_509" name="c__udpgal" order="7" role="product"/>
        <ParameterDescription key="FunctionParameter_510" name="c__udpgal_tot" order="8" role="constant"/>
        <ParameterDescription key="FunctionParameter_511" name="c__udpglcM" order="9" role="substrate"/>
        <ParameterDescription key="FunctionParameter_512" name="c__udpglc_tot" order="10" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_58" name="Function for Galactose-1-phosphate uridyl transferase M3 [c__]" type="UserDefined" reversible="true">
      <Expression>
        (c__gal1pM/c__gal1p_tot*c__udpglcM/c__udpglc_tot*c__GALT_Vf-c__glc1pM/c__glc1p_tot*c__udpgalM/c__udpgal_tot*c__GALT_Vb)/c
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_524" name="c" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_525" name="c__GALT_Vb" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_526" name="c__GALT_Vf" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_527" name="c__gal1pM" order="3" role="substrate"/>
        <ParameterDescription key="FunctionParameter_528" name="c__gal1p_tot" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_529" name="c__glc1pM" order="5" role="product"/>
        <ParameterDescription key="FunctionParameter_530" name="c__glc1p_tot" order="6" role="constant"/>
        <ParameterDescription key="FunctionParameter_531" name="c__udpgalM" order="7" role="product"/>
        <ParameterDescription key="FunctionParameter_532" name="c__udpgal_tot" order="8" role="constant"/>
        <ParameterDescription key="FunctionParameter_533" name="c__udpglcM" order="9" role="substrate"/>
        <ParameterDescription key="FunctionParameter_534" name="c__udpglc_tot" order="10" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_59" name="Function for UDP-glucose 4-epimerase [c__]" type="UserDefined" reversible="true">
      <Expression>
        (c__udpglc/c__udpglc_tot*c__GALE_Vf-c__udpgal/c__udpgal_tot*c__GALE_Vb)/c
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_395" name="c" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_254" name="c__GALE_Vb" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_456" name="c__GALE_Vf" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_457" name="c__udpgal" order="3" role="product"/>
        <ParameterDescription key="FunctionParameter_546" name="c__udpgal_tot" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_547" name="c__udpglc" order="5" role="substrate"/>
        <ParameterDescription key="FunctionParameter_548" name="c__udpglc_tot" order="6" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_60" name="Function for UDP-glucose 4-epimerase M [c__]" type="UserDefined" reversible="true">
      <Expression>
        (c__udpglcM/c__udpglc_tot*c__GALE_Vf-c__udpgalM/c__udpgal_tot*c__GALE_Vb)/c
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_556" name="c" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_557" name="c__GALE_Vb" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_558" name="c__GALE_Vf" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_559" name="c__udpgalM" order="3" role="product"/>
        <ParameterDescription key="FunctionParameter_560" name="c__udpgal_tot" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_561" name="c__udpglcM" order="5" role="substrate"/>
        <ParameterDescription key="FunctionParameter_562" name="c__udpglc_tot" order="6" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_61" name="Function for UDP-glucose pyrophosphorylase [c__]" type="UserDefined" reversible="unspecified">
      <Expression>
        (c__glc1p/c__glc1p_tot*c__UGP_Vf-c__udpglc/c__udpglc_tot*c__UGP_Vb)/c
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_570" name="c" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_571" name="c__UGP_Vb" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_572" name="c__UGP_Vf" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_573" name="c__glc1p" order="3" role="substrate"/>
        <ParameterDescription key="FunctionParameter_574" name="c__glc1p_tot" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_575" name="c__udpglc" order="5" role="product"/>
        <ParameterDescription key="FunctionParameter_576" name="c__udpglc_tot" order="6" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_62" name="Function for UDP-glucose pyrophosphorylase M [c__]" type="UserDefined" reversible="unspecified">
      <Expression>
        (c__glc1pM/c__glc1p_tot*c__UGP_Vf-c__udpglcM/c__udpglc_tot*c__UGP_Vb)/c
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_584" name="c" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_585" name="c__UGP_Vb" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_586" name="c__UGP_Vf" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_587" name="c__glc1pM" order="3" role="substrate"/>
        <ParameterDescription key="FunctionParameter_588" name="c__glc1p_tot" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_589" name="c__udpglcM" order="5" role="product"/>
        <ParameterDescription key="FunctionParameter_590" name="c__udpglc_tot" order="6" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_63" name="Function for UDP-galactose pyrophosphorylase [c__]" type="UserDefined" reversible="unspecified">
      <Expression>
        (c__gal1p/c__gal1p_tot*c__UGALP_Vf-c__udpgal/c__udpgal_tot*c__UGALP_Vb)/c
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_598" name="c" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_599" name="c__UGALP_Vb" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_600" name="c__UGALP_Vf" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_601" name="c__gal1p" order="3" role="substrate"/>
        <ParameterDescription key="FunctionParameter_602" name="c__gal1p_tot" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_603" name="c__udpgal" order="5" role="product"/>
        <ParameterDescription key="FunctionParameter_604" name="c__udpgal_tot" order="6" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_64" name="Function for UDP-galactose pyrophosphorylase M [c__]" type="UserDefined" reversible="unspecified">
      <Expression>
        (c__gal1pM/c__gal1p_tot*c__UGALP_Vf-c__udpgalM/c__udpgal_tot*c__UGALP_Vb)/c
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_612" name="c" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_613" name="c__UGALP_Vb" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_614" name="c__UGALP_Vf" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_615" name="c__gal1pM" order="3" role="substrate"/>
        <ParameterDescription key="FunctionParameter_616" name="c__gal1p_tot" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_617" name="c__udpgalM" order="5" role="product"/>
        <ParameterDescription key="FunctionParameter_618" name="c__udpgal_tot" order="6" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_65" name="Function for Pyrophosphatase [c__]" type="UserDefined" reversible="unspecified">
      <Expression>
        c__PPASE_Vmax*c__ppi^PPASE_n/(c__ppi^PPASE_n+PPASE_k_ppi^PPASE_n)/c
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_392" name="PPASE_k_ppi" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_393" name="PPASE_n" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_626" name="c" order="2" role="volume"/>
        <ParameterDescription key="FunctionParameter_627" name="c__PPASE_Vmax" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_628" name="c__ppi" order="4" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_66" name="Function for ATP:UDP phosphotransferase [c__]" type="UserDefined" reversible="true">
      <Expression>
        c__NDKU_Vmax/NDKU_k_atp/NDKU_k_udp*(c__atp*c__udp-c__adp*c__utp/NDKU_keq)/((1+c__atp/NDKU_k_atp)*(1+c__udp/NDKU_k_udp)+(1+c__adp/NDKU_k_adp)*(1+c__utp/NDKU_k_utp)-1)/c
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_640" name="NDKU_k_adp" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_641" name="NDKU_k_atp" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_642" name="NDKU_k_udp" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_643" name="NDKU_k_utp" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_644" name="NDKU_keq" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_645" name="c" order="5" role="volume"/>
        <ParameterDescription key="FunctionParameter_646" name="c__NDKU_Vmax" order="6" role="constant"/>
        <ParameterDescription key="FunctionParameter_647" name="c__adp" order="7" role="product"/>
        <ParameterDescription key="FunctionParameter_648" name="c__atp" order="8" role="substrate"/>
        <ParameterDescription key="FunctionParameter_649" name="c__udp" order="9" role="substrate"/>
        <ParameterDescription key="FunctionParameter_650" name="c__utp" order="10" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_67" name="Function for Phosphoglucomutase-1 [c__]" type="UserDefined" reversible="true">
      <Expression>
        (c__glc1p/c__glc1p_tot*c__PGM1_Vf-c__glc6p/c__glc6p_tot*c__PGM1_Vb)/c
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_638" name="c" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_345" name="c__PGM1_Vb" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_454" name="c__PGM1_Vf" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_637" name="c__glc1p" order="3" role="substrate"/>
        <ParameterDescription key="FunctionParameter_662" name="c__glc1p_tot" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_663" name="c__glc6p" order="5" role="product"/>
        <ParameterDescription key="FunctionParameter_664" name="c__glc6p_tot" order="6" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_68" name="Function for Phosphoglucomutase-1 M [c__]" type="UserDefined" reversible="true">
      <Expression>
        (c__glc1pM/c__glc1p_tot*c__PGM1_Vf-c__glc6pM/c__glc6p_tot*c__PGM1_Vb)/c
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_672" name="c" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_673" name="c__PGM1_Vb" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_674" name="c__PGM1_Vf" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_675" name="c__glc1pM" order="3" role="substrate"/>
        <ParameterDescription key="FunctionParameter_676" name="c__glc1p_tot" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_677" name="c__glc6pM" order="5" role="product"/>
        <ParameterDescription key="FunctionParameter_678" name="c__glc6p_tot" order="6" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_69" name="Function for Glycolysis [c__]" type="UserDefined" reversible="unspecified">
      <Expression>
        c__GLY_Vmax/GLY_k_glc6p*(c__glc6p-GLY_k_glc6p)*c__phos/(c__phos+GLY_k_p)/c
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_636" name="GLY_k_glc6p" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_686" name="GLY_k_p" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_687" name="c" order="2" role="volume"/>
        <ParameterDescription key="FunctionParameter_688" name="c__GLY_Vmax" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_689" name="c__glc6p" order="4" role="substrate"/>
        <ParameterDescription key="FunctionParameter_690" name="c__phos" order="5" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_70" name="Function for Glycolysis M [c__]" type="UserDefined" reversible="unspecified">
      <Expression>
        c__GLY_Vmax/GLY_k_glc6p*c__glc6pM*c__phos/(c__phos+GLY_k_p)/c
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_697" name="GLY_k_glc6p" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_698" name="GLY_k_p" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_699" name="c" order="2" role="volume"/>
        <ParameterDescription key="FunctionParameter_700" name="c__GLY_Vmax" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_701" name="c__glc6pM" order="4" role="substrate"/>
        <ParameterDescription key="FunctionParameter_702" name="c__phos" order="5" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_71" name="Function for Glycosyltransferase galactose [c__]" type="UserDefined" reversible="unspecified">
      <Expression>
        c__udpgal/c__udpgal_tot*c__GTFGAL_Vf/c
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_391" name="c" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_634" name="c__GTFGAL_Vf" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_709" name="c__udpgal" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_710" name="c__udpgal_tot" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_72" name="Function for Glycosyltransferase galactose M [c__]" type="UserDefined" reversible="unspecified">
      <Expression>
        c__udpgalM/c__udpgal_tot*c__GTFGAL_Vf/c
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_715" name="c" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_716" name="c__GTFGAL_Vf" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_717" name="c__udpgalM" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_718" name="c__udpgal_tot" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_73" name="Function for Glycosyltransferase glucose [c__]" type="UserDefined" reversible="unspecified">
      <Expression>
        c__udpglc/c__udpglc_tot*c__GTFGLC_Vf/c
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_723" name="c" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_724" name="c__GTFGLC_Vf" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_725" name="c__udpglc" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_726" name="c__udpglc_tot" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_74" name="Function for Glycosyltransferase glucose M [c__]" type="UserDefined" reversible="unspecified">
      <Expression>
        c__udpglcM/c__udpglc_tot*c__GTFGLC_Vf/c
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_731" name="c" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_732" name="c__GTFGLC_Vf" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_733" name="c__udpglcM" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_734" name="c__udpglc_tot" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_75" name="Function for H2O M transport [e__]" type="UserDefined" reversible="true">
      <Expression>
        c__H2OT_Vmax/H2OT_k*(e__h2oM-h__h2oM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_739" name="H2OT_k" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_740" name="c__H2OT_Vmax" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_741" name="e__h2oM" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_742" name="h__h2oM" order="3" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_76" name="Function for galactose transport [e__]" type="UserDefined" reversible="true">
      <Expression>
        e__gal/e__gal_tot*c__GLUT2_Vf-c__gal/c__gal_tot*c__GLUT2_Vb
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_749" name="c__GLUT2_Vb" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_750" name="c__GLUT2_Vf" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_751" name="c__gal" order="2" role="product"/>
        <ParameterDescription key="FunctionParameter_752" name="c__gal_tot" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_753" name="e__gal" order="4" role="substrate"/>
        <ParameterDescription key="FunctionParameter_754" name="e__gal_tot" order="5" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_77" name="Function for galactose transport M [e__]" type="UserDefined" reversible="true">
      <Expression>
        e__galM/e__gal_tot*c__GLUT2_Vf-c__galM/c__gal_tot*c__GLUT2_Vb
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_761" name="c__GLUT2_Vb" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_762" name="c__GLUT2_Vf" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_763" name="c__galM" order="2" role="product"/>
        <ParameterDescription key="FunctionParameter_764" name="c__gal_tot" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_765" name="e__galM" order="4" role="substrate"/>
        <ParameterDescription key="FunctionParameter_766" name="e__gal_tot" order="5" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
  </ListOfFunctions>
  <Model key="Model_5" name="galactose_28" simulationType="time" timeUnit="s" volumeUnit="m³" areaUnit="m²" lengthUnit="m" quantityUnit="mol" type="deterministic" avogadroConstant="6.02214179e+23">
    <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:bqbiol="http://biomodels.net/biology-qualifiers/"
   xmlns:dcterms="http://purl.org/dc/terms/"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:vCard="http://www.w3.org/2001/vcard-rdf/3.0#">
  <rdf:Description rdf:about="#Model_5">
    <bqbiol:hasTaxon>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/taxonomy/9606"/>
      </rdf:Bag>
    </bqbiol:hasTaxon>
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2015-12-04T16:55:47Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
    <dcterms:creator>
      <rdf:Bag>
        <rdf:li>
          <rdf:Description>
            <vCard:EMAIL>konigmatt@googlemail.com</vCard:EMAIL>
            <vCard:N>
              <rdf:Description>
                <vCard:Family>Koenig</vCard:Family>
                <vCard:Given>Matthias</vCard:Given>
              </rdf:Description>
            </vCard:N>
            <vCard:ORG>
              <rdf:Description>
                <vCard:Orgname>Charite Berlin</vCard:Orgname>
              </rdf:Description>
            </vCard:ORG>
          </rdf:Description>
        </rdf:li>
      </rdf:Bag>
    </dcterms:creator>
    <dcterms:modified>
      <rdf:Description>
        <dcterms:W3CDTF>2015-12-04T16:55:47Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:modified>
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/bto/BTO:0000575"/>
        <rdf:li rdf:resource="http://identifiers.org/bto/BTO:0000759"/>
        <rdf:li rdf:resource="http://identifiers.org/fma/FMA:14515"/>
        <rdf:li rdf:resource="http://identifiers.org/fma/FMA:7197"/>
        <rdf:li rdf:resource="http://identifiers.org/uberon/UBERON:2107"/>
      </rdf:Bag>
    </CopasiMT:is>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0019388"/>
        <rdf:li rdf:resource="http://identifiers.org/kegg.pathway/map00052"/>
        <rdf:li rdf:resource="http://identifiers.org/metacyc/PWY-6317"/>
        <rdf:li rdf:resource="http://identifiers.org/pw/PW:0000042"/>
        <rdf:li rdf:resource="http://identifiers.org/reactome/REACTOME:R-HSA-70370.1"/>
        <rdf:li rdf:resource="http://identifiers.org/smpdb/SMP00043"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

    </MiriamAnnotation>
    <Comment>
      
  <body xmlns="http://www.w3.org/1999/xhtml">
    <h1>Koenig Human Galactose Metabolism</h1>
    <h2>Description</h2>
    <p>This is a metabolism model of Human galactose metabolism in
    <a href="http://sbml.org" target="_blank" title="Access the definition of the SBML file format.">SBML</a> format.
    </p>
  <div class="dc:provenance">The content of this model has been carefully created in a manual research effort.</div>
  <div class="dc:publisher">This file has been produced by
    <a href="https://livermetabolism.com/contact.html" title="Matthias Koenig" target="_blank">Matthias Koenig</a>.</div><h2>Terms of use</h2><div class="dc:rightsHolder">Copyright © 2015 Matthias Koenig.</div><div class="dc:license">
  <p>Redistribution and use of any part of this model, with or without modification, are permitted provided that the following conditions are met:
        <ol>
    <li>Redistributions of this SBML file must retain the above copyright notice, this list of conditions and the following disclaimer.</li>
    <li>Redistributions in a different form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided
          with the distribution.</li>
  </ol>
        This model is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
        </p>
</div>
</body>

    </Comment>
    <ListOfCompartments>
      <Compartment key="Compartment_7" name="hepatocyte" simulationType="assignment" dimensionality="3">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Compartment_7">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000290"/>
        <rdf:li rdf:resource="http://identifiers.org/bto/BTO:0000575"/>
        <rdf:li rdf:resource="http://identifiers.org/fma/FMA:14515"/>
        <rdf:li rdf:resource="http://identifiers.org/fma/FMA:68646"/>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0005623"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[volume hepatocyte],Reference=Value&gt;
        </Expression>
      </Compartment>
      <Compartment key="Compartment_9" name="cytosol" simulationType="assignment" dimensionality="3">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Compartment_9">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000290"/>
        <rdf:li rdf:resource="http://identifiers.org/fma/FMA:66836"/>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0005829"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[volume cytosol],Reference=Value&gt;
        </Expression>
      </Compartment>
      <Compartment key="Compartment_11" name="external" simulationType="assignment" dimensionality="3">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Compartment_11">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000290"/>
        <rdf:li rdf:resource="http://identifiers.org/fma/FMA:70022"/>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0005615"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[volume external compartment],Reference=Value&gt;
        </Expression>
      </Compartment>
      <Compartment key="Compartment_13" name="plasma membrane" simulationType="assignment" dimensionality="2">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Compartment_13">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000290"/>
        <rdf:li rdf:resource="http://identifiers.org/fma/FMA:63841"/>
        <rdf:li rdf:resource="http://identifiers.org/go/GO:0005886"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[area plasma membrane],Reference=Value&gt;
        </Expression>
      </Compartment>
    </ListOfCompartments>
    <ListOfMetabolites>
      <Metabolite key="Metabolite_51" name="water M*" simulationType="reactions" compartment="Compartment_7">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_51">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000247"/>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:15377"/>
        <rdf:li rdf:resource="http://identifiers.org/kegg.compound/C00001"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_13" name="pyrophosphate" simulationType="reactions" compartment="Compartment_9">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_13">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000247"/>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:33019"/>
      </rdf:Bag>
    </CopasiMT:is>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/kegg.compound/C00013"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_17" name="D-glucose 1-phophate" simulationType="reactions" compartment="Compartment_9">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_17">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000247"/>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:58601"/>
        <rdf:li rdf:resource="http://identifiers.org/kegg.compound/C00103"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_19" name="Acceptor-galactose" simulationType="fixed" compartment="Compartment_9">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_19">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000247"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_21" name="Acceptor (glc/gal)" simulationType="fixed" compartment="Compartment_9">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_21">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000247"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_23" name="UDP-D-galactose" simulationType="reactions" compartment="Compartment_9">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_23">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000247"/>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:66914"/>
      </rdf:Bag>
    </CopasiMT:is>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/kegg.compound/C00052"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_25" name="UDP" simulationType="reactions" compartment="Compartment_9">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_25">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000247"/>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:58223"/>
      </rdf:Bag>
    </CopasiMT:is>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/kegg.compound/C00015"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_27" name="ATP" simulationType="reactions" compartment="Compartment_9">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_27">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000247"/>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:30616"/>
      </rdf:Bag>
    </CopasiMT:is>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/kegg.compound/C00002"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_29" name="UTP" simulationType="reactions" compartment="Compartment_9">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_29">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000247"/>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:46398"/>
      </rdf:Bag>
    </CopasiMT:is>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/kegg.compound/C00075"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_33" name="D-galactose 1-phosphate M*" simulationType="reactions" compartment="Compartment_9">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_33">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000247"/>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:58336"/>
      </rdf:Bag>
    </CopasiMT:is>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/kegg.compound/C00446"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_35" name="D-galactose" simulationType="reactions" compartment="Compartment_9">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_35">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000247"/>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:28061"/>
        <rdf:li rdf:resource="http://identifiers.org/kegg.compound/C00124"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_37" name="Acceptor-galactose M*" simulationType="fixed" compartment="Compartment_9">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_37">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000247"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_39" name="Acceptor-glucose" simulationType="fixed" compartment="Compartment_9">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_39">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000247"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_41" name="D-galactitol M*" simulationType="reactions" compartment="Compartment_9">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_41">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000247"/>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:16813"/>
        <rdf:li rdf:resource="http://identifiers.org/kegg.compound/C01697"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_45" name="O2" simulationType="fixed" compartment="Compartment_9">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_45">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000247"/>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:15379"/>
        <rdf:li rdf:resource="http://identifiers.org/kegg.compound/C00007"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_47" name="D-glucose 6-phosphate" simulationType="reactions" compartment="Compartment_9">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_47">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000247"/>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:58225"/>
      </rdf:Bag>
    </CopasiMT:is>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/kegg.compound/C00668"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_49" name="ADP" simulationType="reactions" compartment="Compartment_9">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_49">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000247"/>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:456216"/>
      </rdf:Bag>
    </CopasiMT:is>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/kegg.compound/C00008"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_53" name="CO2" simulationType="fixed" compartment="Compartment_9">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_53">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000247"/>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:16526"/>
        <rdf:li rdf:resource="http://identifiers.org/kegg.compound/C00011"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_55" name="NADP" simulationType="reactions" compartment="Compartment_9">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_55">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000247"/>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:58349"/>
      </rdf:Bag>
    </CopasiMT:is>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/kegg.compound/C00006"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_57" name="H+" simulationType="fixed" compartment="Compartment_9">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_57">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000247"/>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:15378"/>
        <rdf:li rdf:resource="http://identifiers.org/kegg.compound/C00080"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_59" name="UDP-D-galactose M*" simulationType="reactions" compartment="Compartment_9">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_59">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000247"/>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:66914"/>
      </rdf:Bag>
    </CopasiMT:is>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/kegg.compound/C00052"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_61" name="D-galactose M*" simulationType="reactions" compartment="Compartment_9">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_61">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000247"/>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:28061"/>
        <rdf:li rdf:resource="http://identifiers.org/kegg.compound/C00124"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_63" name="D-galactitol" simulationType="reactions" compartment="Compartment_9">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_63">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000247"/>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:16813"/>
        <rdf:li rdf:resource="http://identifiers.org/kegg.compound/C01697"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_65" name="NADPH" simulationType="reactions" compartment="Compartment_9">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_65">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000247"/>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:57783"/>
      </rdf:Bag>
    </CopasiMT:is>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/kegg.compound/C00005"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_67" name="D-glucose 6-phosphate M*" simulationType="reactions" compartment="Compartment_9">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_67">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000247"/>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:58225"/>
      </rdf:Bag>
    </CopasiMT:is>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/kegg.compound/C00668"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_69" name="D-glucose 1-phophate M*" simulationType="reactions" compartment="Compartment_9">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_69">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000247"/>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:58601"/>
        <rdf:li rdf:resource="http://identifiers.org/kegg.compound/C00103"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_71" name="UDP-D-glucose" simulationType="reactions" compartment="Compartment_9">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_71">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000247"/>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:58885"/>
      </rdf:Bag>
    </CopasiMT:is>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/kegg.compound/C00029"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_73" name="water" simulationType="fixed" compartment="Compartment_9">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_73">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000247"/>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:15377"/>
        <rdf:li rdf:resource="http://identifiers.org/kegg.compound/C00001"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_75" name="D-galactose 1-phosphate" simulationType="reactions" compartment="Compartment_9">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_75">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000247"/>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:58336"/>
      </rdf:Bag>
    </CopasiMT:is>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/kegg.compound/C00446"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_77" name="H2" simulationType="fixed" compartment="Compartment_9">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_77">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000247"/>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:18276"/>
        <rdf:li rdf:resource="http://identifiers.org/kegg.compound/C00282"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_79" name="Acceptor-glucose M*" simulationType="fixed" compartment="Compartment_9">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_79">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000247"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_81" name="UDP-D-glucose M*" simulationType="reactions" compartment="Compartment_9">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_81">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000247"/>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:58885"/>
      </rdf:Bag>
    </CopasiMT:is>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/kegg.compound/C00029"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_83" name="phosphate" simulationType="reactions" compartment="Compartment_9">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_83">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000247"/>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:43474"/>
      </rdf:Bag>
    </CopasiMT:is>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/kegg.compound/C00009"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_15" name="water M*" simulationType="reactions" compartment="Compartment_11">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_15">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000247"/>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:15377"/>
        <rdf:li rdf:resource="http://identifiers.org/kegg.compound/C00001"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_31" name="D-galactose" simulationType="reactions" compartment="Compartment_11">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:dcterms="http://purl.org/dc/terms/"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_31">
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2015-12-05T10:57:43Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000247"/>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:28061"/>
        <rdf:li rdf:resource="http://identifiers.org/kegg.compound/C00124"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
      <Metabolite key="Metabolite_43" name="D-galactose M*" simulationType="reactions" compartment="Compartment_11">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Metabolite_43">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000247"/>
        <rdf:li rdf:resource="http://identifiers.org/chebi/CHEBI:28061"/>
        <rdf:li rdf:resource="http://identifiers.org/kegg.compound/C00124"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </Metabolite>
    </ListOfMetabolites>
    <ListOfModelValues>
      <ModelValue key="ModelValue_13" name="metabolic scaling factor" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_14" name="width hepatocyte" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_15" name="length hepatocyte" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_16" name="cytosolic fraction of hepatocyte" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_17" name="Nf" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_18" name="type of galactosemia" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_19" name="reference protein amount" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_20" name="parenchymal fraction of liver" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_21" name="volume external compartment" simulationType="fixed">
        <InitialExpression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[volume hepatocyte],Reference=InitialValue&gt;
        </InitialExpression>
      </ModelValue>
      <ModelValue key="ModelValue_22" name="volume cytosol" simulationType="fixed">
        <InitialExpression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[cytosolic fraction of hepatocyte],Reference=InitialValue&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[volume hepatocyte],Reference=InitialValue&gt;
        </InitialExpression>
      </ModelValue>
      <ModelValue key="ModelValue_23" name="area plasma membrane" simulationType="fixed">
        <InitialExpression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[length hepatocyte],Reference=InitialValue&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[length hepatocyte],Reference=InitialValue&gt;
        </InitialExpression>
      </ModelValue>
      <ModelValue key="ModelValue_24" name="volume hepatocyte" simulationType="fixed">
        <InitialExpression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[length hepatocyte],Reference=InitialValue&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[length hepatocyte],Reference=InitialValue&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[width hepatocyte],Reference=InitialValue&gt;
        </InitialExpression>
      </ModelValue>
      <ModelValue key="ModelValue_25" name="c__gal_tot" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[D-galactose],Reference=Concentration&gt;+&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[D-galactose M*],Reference=Concentration&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_26" name="e__gal_tot" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Compartments[external],Vector=Metabolites[D-galactose],Reference=Concentration&gt;+&lt;CN=Root,Model=galactose_28,Vector=Compartments[external],Vector=Metabolites[D-galactose M*],Reference=Concentration&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_27" name="c__udpglc_tot" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[UDP-D-glucose],Reference=Concentration&gt;+&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[UDP-D-glucose M*],Reference=Concentration&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_28" name="ADP balance" simulationType="assignment">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_28">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000196"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[ATP],Reference=Concentration&gt;+&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[ADP],Reference=Concentration&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_29" name="Phosphate balance" simulationType="assignment">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_29">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000196"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <Expression>
          3*&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[ATP],Reference=Concentration&gt;+2*&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[ADP],Reference=Concentration&gt;+3*&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[UTP],Reference=Concentration&gt;+2*&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[UDP],Reference=Concentration&gt;+&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[phosphate],Reference=Concentration&gt;+2*&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[pyrophosphate],Reference=Concentration&gt;+&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[D-glucose 1-phophate],Reference=Concentration&gt;+&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[D-glucose 6-phosphate],Reference=Concentration&gt;+&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[D-galactose 1-phosphate],Reference=Concentration&gt;+2*&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[UDP-D-glucose],Reference=Concentration&gt;+2*&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[UDP-D-galactose],Reference=Concentration&gt;+&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[D-glucose 1-phophate M*],Reference=Concentration&gt;+&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[D-glucose 6-phosphate M*],Reference=Concentration&gt;+&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[D-galactose 1-phosphate M*],Reference=Concentration&gt;+2*&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[UDP-D-glucose M*],Reference=Concentration&gt;+2*&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[UDP-D-galactose M*],Reference=Concentration&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_30" name="c__glc6p_tot" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[D-glucose 6-phosphate],Reference=Concentration&gt;+&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[D-glucose 6-phosphate M*],Reference=Concentration&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_31" name="c__gal1p_tot" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[D-galactose 1-phosphate],Reference=Concentration&gt;+&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[D-galactose 1-phosphate M*],Reference=Concentration&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_32" name="c__scale" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[metabolic scaling factor],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[volume hepatocyte],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_33" name="c__galtol_tot" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[D-galactitol],Reference=Concentration&gt;+&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[D-galactitol M*],Reference=Concentration&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_34" name="c__glc1p_tot" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[D-glucose 1-phophate],Reference=Concentration&gt;+&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[D-glucose 1-phophate M*],Reference=Concentration&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_35" name="c__udpgal_tot" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[UDP-D-galactose],Reference=Concentration&gt;+&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[UDP-D-galactose M*],Reference=Concentration&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_36" name="UDP balance" simulationType="assignment">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_36">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000196"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[UTP],Reference=Concentration&gt;+&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[UDP],Reference=Concentration&gt;+&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[UDP-D-glucose],Reference=Concentration&gt;+&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[UDP-D-galactose],Reference=Concentration&gt;+&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[UDP-D-glucose M*],Reference=Concentration&gt;+&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[UDP-D-galactose M*],Reference=Concentration&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_37" name="NADP balance" simulationType="assignment">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_37">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000196"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[NADP],Reference=Concentration&gt;+&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[NADPH],Reference=Concentration&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_38" name="GALK_PA" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_39" name="GALK_keq" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_39">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000281"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_40" name="GALK_k_gal1p" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:dcterms="http://purl.org/dc/terms/"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_40">
    <dcterms:bibliographicCitation>
      <rdf:Bag>
        <rdf:li>
          <rdf:Description>
            <CopasiMT:isDescribedBy rdf:resource="http://identifiers.org/pubmed/12694189"/>
          </rdf:Description>
        </rdf:li>
        <rdf:li>
          <rdf:Description>
            <CopasiMT:isDescribedBy rdf:resource="http://identifiers.org/pubmed/15024738"/>
          </rdf:Description>
        </rdf:li>
      </rdf:Bag>
    </dcterms:bibliographicCitation>
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000027"/>
        <rdf:li rdf:resource="http://identifiers.org/sabiork.kineticrecord/14785"/>
        <rdf:li rdf:resource="http://identifiers.org/sabiork.kineticrecord/45367"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_41" name="GALK_k_adp" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_41">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000027"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_42" name="GALK_ki_gal1p" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_42">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000261"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_43" name="GALK_kcat" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:dcterms="http://purl.org/dc/terms/"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_43">
    <dcterms:bibliographicCitation>
      <rdf:Bag>
        <rdf:li>
          <rdf:Description>
            <CopasiMT:isDescribedBy rdf:resource="http://identifiers.org/pubmed/12694189"/>
          </rdf:Description>
        </rdf:li>
      </rdf:Bag>
    </dcterms:bibliographicCitation>
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000025"/>
        <rdf:li rdf:resource="http://identifiers.org/sabiork.kineticrecord/14785"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_44" name="GALK_k_gal" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:dcterms="http://purl.org/dc/terms/"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_44">
    <dcterms:bibliographicCitation>
      <rdf:Bag>
        <rdf:li>
          <rdf:Description>
            <CopasiMT:isDescribedBy rdf:resource="http://identifiers.org/pubmed/12694189"/>
          </rdf:Description>
        </rdf:li>
        <rdf:li>
          <rdf:Description>
            <CopasiMT:isDescribedBy rdf:resource="http://identifiers.org/pubmed/15024738"/>
          </rdf:Description>
        </rdf:li>
      </rdf:Bag>
    </dcterms:bibliographicCitation>
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000027"/>
        <rdf:li rdf:resource="http://identifiers.org/sabiork.kineticrecord/14785"/>
        <rdf:li rdf:resource="http://identifiers.org/sabiork.kineticrecord/45367"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_45" name="GALK_k_atp" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:dcterms="http://purl.org/dc/terms/"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_45">
    <dcterms:bibliographicCitation>
      <rdf:Bag>
        <rdf:li>
          <rdf:Description>
            <CopasiMT:isDescribedBy rdf:resource="http://identifiers.org/pubmed/12694189"/>
          </rdf:Description>
        </rdf:li>
      </rdf:Bag>
    </dcterms:bibliographicCitation>
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000027"/>
        <rdf:li rdf:resource="http://identifiers.org/sabiork.kineticrecord/14792"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_46" name="c__GALK_P" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_47" name="c__GALK_V" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[c__GALK_Vmax],Reference=Value&gt;/(&lt;CN=Root,Model=galactose_28,Vector=Values[GALK_k_gal],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[GALK_k_atp],Reference=Value&gt;)*1/(1+&lt;CN=Root,Model=galactose_28,Vector=Values[c__gal1p_tot],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[GALK_ki_gal1p],Reference=Value&gt;)*1/&lt;CN=Root,Model=galactose_28,Vector=Values[c__GALK_dm],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_48" name="c__GALK_Vb" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[c__GALK_V],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__gal1p_tot],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[ADP],Reference=Concentration&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[GALK_keq],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_49" name="c__GALK_Vmax" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[c__scale],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[GALK_PA],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[GALK_kcat],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__GALK_P],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[reference protein amount],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_50" name="c__GALK_dm" simulationType="assignment">
        <Expression>
          (1+&lt;CN=Root,Model=galactose_28,Vector=Values[c__gal_tot],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[GALK_k_gal],Reference=Value&gt;)*(1+&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[ATP],Reference=Concentration&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[GALK_k_atp],Reference=Value&gt;)+(1+&lt;CN=Root,Model=galactose_28,Vector=Values[c__gal1p_tot],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[GALK_k_gal1p],Reference=Value&gt;)*(1+&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[ADP],Reference=Concentration&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[GALK_k_adp],Reference=Value&gt;)-1
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_51" name="c__GALK_Vf" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[c__GALK_V],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__gal_tot],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[ATP],Reference=Concentration&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_52" name="IMP_f" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_53" name="IMP_k_gal1p" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_53">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000027"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_54" name="c__IMP_P" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_55" name="c__IMP_dm" simulationType="assignment">
        <Expression>
          1+&lt;CN=Root,Model=galactose_28,Vector=Values[c__gal1p_tot],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[IMP_k_gal1p],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_56" name="c__IMP_Vf" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[c__IMP_Vmax],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[IMP_k_gal1p],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__gal1p_tot],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[c__IMP_dm],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_57" name="c__IMP_Vmax" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[IMP_f],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__GALK_Vmax],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__IMP_P],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[reference protein amount],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_58" name="ATPS_f" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_59" name="ATPS_keq" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_59">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000281"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_60" name="ATPS_k_adp" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_60">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000027"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_61" name="ATPS_k_atp" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_61">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000027"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_62" name="ATPS_k_phos" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_62">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000027"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_63" name="c__ATPS_P" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_64" name="c__ATPS_Vmax" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[ATPS_f],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__GALK_Vmax],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__ATPS_P],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[reference protein amount],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_65" name="ALDR_f" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_66" name="ALDR_keq" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_66">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000281"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_67" name="ALDR_k_gal" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_67">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000027"/>
        <rdf:li rdf:resource="http://identifiers.org/sabiork.kineticrecord/15695"/>
        <rdf:li rdf:resource="http://identifiers.org/sabiork.kineticrecord/22893"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_68" name="ALDR_k_galtol" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_68">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000027"/>
        <rdf:li rdf:resource="http://identifiers.org/sabiork.kineticrecord/15695"/>
        <rdf:li rdf:resource="http://identifiers.org/sabiork.kineticrecord/22893"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_69" name="ALDR_k_nadp" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_69">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000027"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_70" name="ALDR_k_nadph" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_70">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000027"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_71" name="c__ALDR_P" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_72" name="c__ALDR_Vb" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[c__ALDR_V],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__galtol_tot],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[NADP],Reference=Concentration&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[ALDR_keq],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_73" name="c__ALDR_V" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[c__ALDR_Vmax],Reference=Value&gt;/(&lt;CN=Root,Model=galactose_28,Vector=Values[ALDR_k_gal],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[ALDR_k_nadp],Reference=Value&gt;)*1/&lt;CN=Root,Model=galactose_28,Vector=Values[c__ALDR_dm],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_74" name="c__ALDR_Vmax" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[ALDR_f],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__GALK_Vmax],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__ALDR_P],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[reference protein amount],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_75" name="c__ALDR_dm" simulationType="assignment">
        <Expression>
          (1+&lt;CN=Root,Model=galactose_28,Vector=Values[c__gal_tot],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[ALDR_k_gal],Reference=Value&gt;)*(1+&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[NADPH],Reference=Concentration&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[ALDR_k_nadph],Reference=Value&gt;)+(1+&lt;CN=Root,Model=galactose_28,Vector=Values[c__galtol_tot],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[ALDR_k_galtol],Reference=Value&gt;)*(1+&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[NADP],Reference=Concentration&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[ALDR_k_nadp],Reference=Value&gt;)-1
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_76" name="c__ALDR_Vf" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[c__ALDR_V],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__gal_tot],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[NADPH],Reference=Concentration&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_77" name="NADPR_f" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_78" name="NADPR_keq" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_78">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000281"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_79" name="NADPR_k_nadp" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_79">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000027"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_80" name="NADPR_ki_nadph" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_80">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000261"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_81" name="c__NADPR_P" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_82" name="c__NADPR_Vmax" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[NADPR_f],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__ALDR_Vmax],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__NADPR_P],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[reference protein amount],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_83" name="GALT_f" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_84" name="GALT_keq" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_84">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000281"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_85" name="GALT_k_glc1p" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_85">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000027"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_86" name="GALT_k_udpgal" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_86">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000027"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_87" name="GALT_ki_utp" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_87">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000261"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_88" name="GALT_ki_udp" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_88">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000261"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_89" name="GALT_vm" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_90" name="GALT_k_gal1p" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_90">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000027"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_91" name="GALT_k_udpglc" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_91">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000027"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_92" name="c__GALT_P" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_93" name="c__GALT_Vf" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[c__GALT_V],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__gal1p_tot],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__udpglc_tot],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_94" name="c__GALT_V" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[c__GALT_Vmax],Reference=Value&gt;/(&lt;CN=Root,Model=galactose_28,Vector=Values[GALT_k_gal1p],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[GALT_k_udpglc],Reference=Value&gt;)*1/&lt;CN=Root,Model=galactose_28,Vector=Values[c__GALT_dm],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_95" name="c__GALT_Vmax" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[c__GALT_P],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[reference protein amount],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[GALT_f],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__GALK_Vmax],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[GALT_vm],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_96" name="c__GALT_Vb" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[c__GALT_V],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__glc1p_tot],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__udpgal_tot],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[GALT_keq],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_97" name="c__GALT_dm" simulationType="assignment">
        <Expression>
          (1+&lt;CN=Root,Model=galactose_28,Vector=Values[c__gal1p_tot],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[GALT_k_gal1p],Reference=Value&gt;)*(1+&lt;CN=Root,Model=galactose_28,Vector=Values[c__udpglc_tot],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[GALT_k_udpglc],Reference=Value&gt;+&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[UDP],Reference=Concentration&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[GALT_ki_udp],Reference=Value&gt;+&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[UTP],Reference=Concentration&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[GALT_ki_utp],Reference=Value&gt;)+(1+&lt;CN=Root,Model=galactose_28,Vector=Values[c__glc1p_tot],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[GALT_k_glc1p],Reference=Value&gt;)*(1+&lt;CN=Root,Model=galactose_28,Vector=Values[c__udpgal_tot],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[GALT_k_udpgal],Reference=Value&gt;)-1
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_98" name="GALE_f" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_99" name="GALE_PA" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_100" name="GALE_kcat" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_100">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000025"/>
        <rdf:li rdf:resource="http://identifiers.org/sabiork.kineticrecord/16222"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_101" name="GALE_keq" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_101">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000281"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_102" name="GALE_k_udpglc" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_102">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000027"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_103" name="GALE_k_udpgal" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_103">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000027"/>
        <rdf:li rdf:resource="http://identifiers.org/sabiork.kineticrecord/19823"/>
        <rdf:li rdf:resource="http://identifiers.org/sabiork.kineticrecord/46260"/>
        <rdf:li rdf:resource="http://identifiers.org/sabiork.kineticrecord/46263"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_104" name="c__GALE_P" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_105" name="c__GALE_Vb" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[c__GALE_V],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__udpgal_tot],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[GALE_keq],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_106" name="c__GALE_V" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[c__GALE_Vmax],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[GALE_k_udpglc],Reference=Value&gt;*1/&lt;CN=Root,Model=galactose_28,Vector=Values[c__GALE_dm],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_107" name="c__GALE_Vmax" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[GALE_f],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__GALK_Vmax],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[GALE_PA],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[GALE_kcat],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__GALE_P],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[reference protein amount],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_108" name="c__GALE_dm" simulationType="assignment">
        <Expression>
          1+&lt;CN=Root,Model=galactose_28,Vector=Values[c__udpglc_tot],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[GALE_k_udpglc],Reference=Value&gt;+&lt;CN=Root,Model=galactose_28,Vector=Values[c__udpgal_tot],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[GALE_k_udpgal],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_109" name="c__GALE_Vf" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[c__GALE_V],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__udpglc_tot],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_110" name="UGP_f" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_111" name="UGP_keq" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_111">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000281"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_112" name="UGP_k_utp" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_112">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000027"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_113" name="UGP_k_glc1p" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_113">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000027"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_114" name="UGP_k_udpglc" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_114">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000027"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_115" name="UGP_k_ppi" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_115">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000027"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_116" name="UGP_k_gal1p" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_116">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000027"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_117" name="UGP_k_udpgal" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_117">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000027"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_118" name="UGP_ki_utp" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_118">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000261"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_119" name="UGP_ki_udpglc" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_119">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000261"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_120" name="c__UGP_P" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_121" name="c__UGP_Vf" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[c__UGP_V],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__glc1p_tot],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[UTP],Reference=Concentration&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_122" name="c__UGP_V" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[c__UGP_Vmax],Reference=Value&gt;/(&lt;CN=Root,Model=galactose_28,Vector=Values[UGP_k_utp],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[UGP_k_glc1p],Reference=Value&gt;)*1/&lt;CN=Root,Model=galactose_28,Vector=Values[c__UGP_dm],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_123" name="c__UGP_Vmax" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[UGP_f],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__GALK_Vmax],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__UGP_P],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[reference protein amount],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_124" name="c__UGP_dm" simulationType="assignment">
        <Expression>
          (1+&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[UTP],Reference=Concentration&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[UGP_k_utp],Reference=Value&gt;+&lt;CN=Root,Model=galactose_28,Vector=Values[c__udpglc_tot],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[UGP_ki_udpglc],Reference=Value&gt;)*(1+&lt;CN=Root,Model=galactose_28,Vector=Values[c__glc1p_tot],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[UGP_k_glc1p],Reference=Value&gt;+&lt;CN=Root,Model=galactose_28,Vector=Values[c__gal1p_tot],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[UGP_k_gal1p],Reference=Value&gt;)+(1+&lt;CN=Root,Model=galactose_28,Vector=Values[c__udpglc_tot],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[UGP_k_udpglc],Reference=Value&gt;+&lt;CN=Root,Model=galactose_28,Vector=Values[c__udpgal_tot],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[UGP_k_udpgal],Reference=Value&gt;+&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[UTP],Reference=Concentration&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[UGP_ki_utp],Reference=Value&gt;)*(1+&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[pyrophosphate],Reference=Concentration&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[UGP_k_ppi],Reference=Value&gt;)-1
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_125" name="c__UGP_Vb" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[c__UGP_V],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__udpglc_tot],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[pyrophosphate],Reference=Concentration&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[UGP_keq],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_126" name="UGALP_f" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_127" name="c__UGALP_Vb" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[c__UGALP_V],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__udpgal_tot],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[pyrophosphate],Reference=Concentration&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[UGP_keq],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_128" name="c__UGALP_V" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[UGALP_f],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__UGP_Vmax],Reference=Value&gt;/(&lt;CN=Root,Model=galactose_28,Vector=Values[UGP_k_utp],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[UGP_k_gal1p],Reference=Value&gt;)*1/&lt;CN=Root,Model=galactose_28,Vector=Values[c__UGP_dm],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_129" name="c__UGALP_Vf" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[c__UGALP_V],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__gal1p_tot],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[UTP],Reference=Concentration&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_130" name="PPASE_f" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_131" name="PPASE_k_ppi" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_131">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000027"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_132" name="PPASE_n" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_133" name="c__PPASE_P" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_134" name="c__PPASE_Vmax" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[PPASE_f],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__UGP_Vmax],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__PPASE_P],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[reference protein amount],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_135" name="NDKU_f" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_136" name="NDKU_keq" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_136">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000281"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_137" name="NDKU_k_atp" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_137">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000027"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_138" name="NDKU_k_adp" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_138">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000027"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_139" name="NDKU_k_utp" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_139">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000027"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_140" name="NDKU_k_udp" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_140">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000027"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_141" name="c__NDKU_P" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_142" name="c__NDKU_Vmax" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[NDKU_f],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__UGP_Vmax],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__NDKU_P],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[reference protein amount],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_143" name="PGM1_f" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_144" name="PGM1_keq" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_144">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000281"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_145" name="PGM1_k_glc6p" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_145">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000027"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_146" name="PGM1_k_glc1p" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_146">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000027"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_147" name="c__PGM1_P" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_148" name="c__PGM1_Vb" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[c__PGM1_V],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__glc6p_tot],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[PGM1_keq],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_149" name="c__PGM1_V" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[c__PGM1_Vmax],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[PGM1_k_glc1p],Reference=Value&gt;*1/&lt;CN=Root,Model=galactose_28,Vector=Values[c__PGM1_dm],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_150" name="c__PGM1_Vmax" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[PGM1_f],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__GALK_Vmax],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__PGM1_P],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[reference protein amount],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_151" name="c__PGM1_dm" simulationType="assignment">
        <Expression>
          1+&lt;CN=Root,Model=galactose_28,Vector=Values[c__glc1p_tot],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[PGM1_k_glc1p],Reference=Value&gt;+&lt;CN=Root,Model=galactose_28,Vector=Values[c__glc6p_tot],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[PGM1_k_glc6p],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_152" name="c__PGM1_Vf" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[c__PGM1_V],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__glc1p_tot],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_153" name="GLY_f" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_154" name="GLY_k_glc6p" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_154">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000027"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_155" name="GLY_k_p" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_155">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000027"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_156" name="c__GLY_P" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_157" name="c__GLY_Vmax" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[GLY_f],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__PGM1_Vmax],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__GLY_P],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[reference protein amount],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_158" name="GTF_f" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_159" name="GTF_k_udpgal" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_159">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000027"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_160" name="GTF_k_udpglc" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_160">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000027"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_161" name="c__GTF_P" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_162" name="c__GTFGAL_Vf" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[c__GTF_Vmax],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[GTF_k_udpgal],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__udpgal_tot],Reference=Value&gt;/(1+&lt;CN=Root,Model=galactose_28,Vector=Values[c__udpgal_tot],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[GTF_k_udpgal],Reference=Value&gt;)
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_163" name="c__GTF_Vmax" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[GTF_f],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__GALK_Vmax],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__GTF_P],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[reference protein amount],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_164" name="c__GTFGLC_Vf" simulationType="assignment">
        <Expression>
          0*&lt;CN=Root,Model=galactose_28,Vector=Values[c__GTF_Vmax],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[GTF_k_udpglc],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__udpglc_tot],Reference=Value&gt;/(1+&lt;CN=Root,Model=galactose_28,Vector=Values[c__udpglc_tot],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[GTF_k_udpglc],Reference=Value&gt;)
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_165" name="H2OT_f" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_166" name="H2OT_k" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_167" name="c__H2OT_Vmax" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[H2OT_f],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[Nf],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__scale],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_168" name="GLUT2_f" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_169" name="GLUT2_k_gal" simulationType="fixed">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#ModelValue_169">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000027"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
      </ModelValue>
      <ModelValue key="ModelValue_170" name="c__GLUT2_P" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_171" name="c__GLUT2_dm" simulationType="assignment">
        <Expression>
          1+&lt;CN=Root,Model=galactose_28,Vector=Values[e__gal_tot],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[GLUT2_k_gal],Reference=Value&gt;+&lt;CN=Root,Model=galactose_28,Vector=Values[c__gal_tot],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[GLUT2_k_gal],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_172" name="c__GLUT2_Vb" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[c__GLUT2_V],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__gal_tot],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_173" name="c__GLUT2_V" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[c__GLUT2_Vmax],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[GLUT2_k_gal],Reference=Value&gt;*1/&lt;CN=Root,Model=galactose_28,Vector=Values[c__GLUT2_dm],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_174" name="c__GLUT2_Vf" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[c__GLUT2_V],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[e__gal_tot],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_175" name="c__GLUT2_Vmax" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=galactose_28,Vector=Values[GLUT2_f],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[Nf],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__scale],Reference=Value&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[c__GLUT2_P],Reference=Value&gt;/&lt;CN=Root,Model=galactose_28,Vector=Values[reference protein amount],Reference=Value&gt;
        </Expression>
      </ModelValue>
    </ListOfModelValues>
    <ListOfReactions>
      <Reaction key="Reaction_7" name="Galactokinase [c__]" reversible="true" fast="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:bqbiol="http://biomodels.net/biology-qualifiers/"
   xmlns:dcterms="http://purl.org/dc/terms/"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_7">
    <bqbiol:hasProperty>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/omim/230200"/>
      </rdf:Bag>
    </bqbiol:hasProperty>
    <dcterms:bibliographicCitation>
      <rdf:Bag>
        <rdf:li>
          <rdf:Description>
            <CopasiMT:isDescribedBy rdf:resource="http://identifiers.org/pubmed/12694189"/>
          </rdf:Description>
        </rdf:li>
      </rdf:Bag>
    </dcterms:bibliographicCitation>
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000176"/>
        <rdf:li rdf:resource="http://identifiers.org/ec-code/2.7.1.6"/>
        <rdf:li rdf:resource="http://identifiers.org/kegg.reaction/R01092"/>
        <rdf:li rdf:resource="http://identifiers.org/reactome/REACTOME:R-HSA-70355.1"/>
        <rdf:li rdf:resource="http://identifiers.org/rhea/13556"/>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P51570"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_35" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_27" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_75" stoichiometry="1"/>
          <Product metabolite="Metabolite_49" stoichiometry="1"/>
          <Product metabolite="Metabolite_57" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_61" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_33" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4190" name="c__GALK_Vb" value="2.33831e-20"/>
          <Constant key="Parameter_4189" name="c__GALK_Vf" value="3.15672e-19"/>
          <Constant key="Parameter_4188" name="c__gal1p_tot" value="0.001"/>
          <Constant key="Parameter_4187" name="c__gal_tot" value="0.00012"/>
        </ListOfConstants>
        <KineticLaw function="Function_47">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_350">
              <SourceParameter reference="Compartment_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_351">
              <SourceParameter reference="ModelValue_48"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_352">
              <SourceParameter reference="ModelValue_51"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_353">
              <SourceParameter reference="Metabolite_35"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_354">
              <SourceParameter reference="Metabolite_75"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_355">
              <SourceParameter reference="ModelValue_31"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_356">
              <SourceParameter reference="ModelValue_25"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_8" name="Galactokinase M [c__]" reversible="false" fast="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:bqbiol="http://biomodels.net/biology-qualifiers/"
   xmlns:dcterms="http://purl.org/dc/terms/"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_8">
    <bqbiol:hasProperty>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/omim/230200"/>
      </rdf:Bag>
    </bqbiol:hasProperty>
    <dcterms:bibliographicCitation>
      <rdf:Bag>
        <rdf:li>
          <rdf:Description>
            <CopasiMT:isDescribedBy rdf:resource="http://identifiers.org/pubmed/12694189"/>
          </rdf:Description>
        </rdf:li>
      </rdf:Bag>
    </dcterms:bibliographicCitation>
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000176"/>
        <rdf:li rdf:resource="http://identifiers.org/ec-code/2.7.1.6"/>
        <rdf:li rdf:resource="http://identifiers.org/kegg.reaction/R01092"/>
        <rdf:li rdf:resource="http://identifiers.org/reactome/REACTOME:R-HSA-70355.1"/>
        <rdf:li rdf:resource="http://identifiers.org/rhea/13556"/>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P51570"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_61" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_27" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_33" stoichiometry="1"/>
          <Product metabolite="Metabolite_49" stoichiometry="1"/>
          <Product metabolite="Metabolite_57" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_35" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_75" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4186" name="c__GALK_Vb" value="2.33831e-20"/>
          <Constant key="Parameter_4185" name="c__GALK_Vf" value="3.15672e-19"/>
          <Constant key="Parameter_4184" name="c__gal1p_tot" value="0.001"/>
          <Constant key="Parameter_4183" name="c__gal_tot" value="0.00012"/>
        </ListOfConstants>
        <KineticLaw function="Function_48">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_364">
              <SourceParameter reference="Compartment_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_365">
              <SourceParameter reference="ModelValue_48"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_366">
              <SourceParameter reference="ModelValue_51"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_367">
              <SourceParameter reference="Metabolite_33"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_368">
              <SourceParameter reference="ModelValue_31"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_369">
              <SourceParameter reference="Metabolite_61"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_370">
              <SourceParameter reference="ModelValue_25"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_9" name="Inositol monophosphatase [c__]" reversible="false" fast="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_9">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000176"/>
        <rdf:li rdf:resource="http://identifiers.org/ec-code/3.1.3.25"/>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P29218"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_75" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_73" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_35" stoichiometry="1"/>
          <Product metabolite="Metabolite_83" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_33" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4182" name="c__IMP_Vf" value="5.41705e-20"/>
          <Constant key="Parameter_4181" name="c__gal1p_tot" value="0.001"/>
        </ListOfConstants>
        <KineticLaw function="Function_49">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_346">
              <SourceParameter reference="Compartment_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_348">
              <SourceParameter reference="ModelValue_56"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_349">
              <SourceParameter reference="Metabolite_75"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_378">
              <SourceParameter reference="ModelValue_31"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_10" name="Inositol monophosphatase M [c__]" reversible="false" fast="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_10">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000176"/>
        <rdf:li rdf:resource="http://identifiers.org/ec-code/3.1.3.25"/>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P29218"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_33" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_73" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_61" stoichiometry="1"/>
          <Product metabolite="Metabolite_83" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_75" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4180" name="c__IMP_Vf" value="5.41705e-20"/>
          <Constant key="Parameter_4179" name="c__gal1p_tot" value="0.001"/>
        </ListOfConstants>
        <KineticLaw function="Function_50">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_383">
              <SourceParameter reference="Compartment_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_384">
              <SourceParameter reference="ModelValue_56"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_385">
              <SourceParameter reference="Metabolite_33"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_386">
              <SourceParameter reference="ModelValue_31"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_11" name="ATP synthase [c__]" reversible="true" fast="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_11">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000176"/>
        <rdf:li rdf:resource="http://identifiers.org/kegg.reaction/R00086"/>
        <rdf:li rdf:resource="http://identifiers.org/rhea/13068"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_49" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_83" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_57" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_27" stoichiometry="1"/>
          <Product metabolite="Metabolite_73" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4178" name="ATPS_k_adp" value="0.1"/>
          <Constant key="Parameter_4177" name="ATPS_k_atp" value="0.5"/>
          <Constant key="Parameter_4176" name="ATPS_k_phos" value="0.1"/>
          <Constant key="Parameter_4175" name="ATPS_keq" value="0.58"/>
          <Constant key="Parameter_4174" name="c__ATPS_Vmax" value="3.80277e-14"/>
        </ListOfConstants>
        <KineticLaw function="Function_51">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_396">
              <SourceParameter reference="ModelValue_60"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_397">
              <SourceParameter reference="ModelValue_61"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_398">
              <SourceParameter reference="ModelValue_62"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_399">
              <SourceParameter reference="ModelValue_59"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_400">
              <SourceParameter reference="Compartment_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_401">
              <SourceParameter reference="ModelValue_64"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_402">
              <SourceParameter reference="Metabolite_49"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_403">
              <SourceParameter reference="Metabolite_27"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_404">
              <SourceParameter reference="Metabolite_83"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_12" name="Aldose reductase [c__]" reversible="true" fast="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:dcterms="http://purl.org/dc/terms/"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_12">
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2015-12-05T10:56:02Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000176"/>
        <rdf:li rdf:resource="http://identifiers.org/ec-code/1.1.1.21"/>
      </rdf:Bag>
    </CopasiMT:is>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/kegg.reaction/R01095"/>
        <rdf:li rdf:resource="http://identifiers.org/rhea/37967"/>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P15121"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_35" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_65" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_57" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_63" stoichiometry="1"/>
          <Product metabolite="Metabolite_55" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_61" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_41" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4173" name="c__ALDR_Vb" value="7.92229e-16"/>
          <Constant key="Parameter_4172" name="c__ALDR_Vf" value="3.8027e-16"/>
          <Constant key="Parameter_4171" name="c__gal_tot" value="0.00012"/>
          <Constant key="Parameter_4170" name="c__galtol_tot" value="0.001"/>
        </ListOfConstants>
        <KineticLaw function="Function_52">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_394">
              <SourceParameter reference="Compartment_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_258">
              <SourceParameter reference="ModelValue_72"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_414">
              <SourceParameter reference="ModelValue_76"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_415">
              <SourceParameter reference="Metabolite_35"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_416">
              <SourceParameter reference="ModelValue_25"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_417">
              <SourceParameter reference="Metabolite_63"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_418">
              <SourceParameter reference="ModelValue_33"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_13" name="Aldose reductase M [c__]" reversible="true" fast="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_13">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000176"/>
        <rdf:li rdf:resource="http://identifiers.org/ec-code/1.1.1.21"/>
      </rdf:Bag>
    </CopasiMT:is>
    <CopasiMT:isVersionOf>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/kegg.reaction/R01095"/>
        <rdf:li rdf:resource="http://identifiers.org/rhea/37967"/>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P15121"/>
      </rdf:Bag>
    </CopasiMT:isVersionOf>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_61" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_65" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_57" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_41" stoichiometry="1"/>
          <Product metabolite="Metabolite_55" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_35" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_63" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4169" name="c__ALDR_Vb" value="7.92229e-16"/>
          <Constant key="Parameter_4168" name="c__ALDR_Vf" value="3.8027e-16"/>
          <Constant key="Parameter_4167" name="c__gal_tot" value="0.00012"/>
          <Constant key="Parameter_4166" name="c__galtol_tot" value="0.001"/>
        </ListOfConstants>
        <KineticLaw function="Function_53">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_426">
              <SourceParameter reference="Compartment_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_427">
              <SourceParameter reference="ModelValue_72"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_428">
              <SourceParameter reference="ModelValue_76"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_429">
              <SourceParameter reference="Metabolite_61"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_430">
              <SourceParameter reference="ModelValue_25"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_431">
              <SourceParameter reference="Metabolite_41"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_432">
              <SourceParameter reference="ModelValue_33"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_14" name="NADP Reductase [c__]" reversible="true" fast="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_14">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000176"/>
        <rdf:li rdf:resource="http://identifiers.org/ec-code/1.1.1.49"/>
        <rdf:li rdf:resource="http://identifiers.org/kegg.reaction/R00835"/>
        <rdf:li rdf:resource="http://identifiers.org/rhea/15844"/>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P11413"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_55" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_77" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_65" stoichiometry="1"/>
          <Product metabolite="Metabolite_57" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4165" name="NADPR_k_nadp" value="0.015"/>
          <Constant key="Parameter_4164" name="NADPR_keq" value="1"/>
          <Constant key="Parameter_4163" name="NADPR_ki_nadph" value="0.01"/>
          <Constant key="Parameter_4162" name="c__NADPR_Vmax" value="3.80277e-20"/>
        </ListOfConstants>
        <KineticLaw function="Function_54">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_440">
              <SourceParameter reference="ModelValue_79"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_441">
              <SourceParameter reference="ModelValue_78"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_442">
              <SourceParameter reference="ModelValue_80"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_443">
              <SourceParameter reference="Compartment_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_444">
              <SourceParameter reference="ModelValue_82"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_445">
              <SourceParameter reference="Metabolite_55"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_446">
              <SourceParameter reference="Metabolite_65"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_15" name="Galactose-1-phosphate uridyl transferase [c__]" reversible="true" fast="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:bqbiol="http://biomodels.net/biology-qualifiers/"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_15">
    <bqbiol:hasProperty>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/omim/230400"/>
      </rdf:Bag>
    </bqbiol:hasProperty>
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000176"/>
        <rdf:li rdf:resource="http://identifiers.org/ec-code/2.7.7.12"/>
        <rdf:li rdf:resource="http://identifiers.org/kegg.reaction/R00955"/>
        <rdf:li rdf:resource="http://identifiers.org/rhea/13992"/>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P07902"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_75" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_71" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_17" stoichiometry="1"/>
          <Product metabolite="Metabolite_23" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_29" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_25" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_33" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_81" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_17" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_59" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4161" name="c__GALT_Vb" value="1.71128e-18"/>
          <Constant key="Parameter_4160" name="c__GALT_Vf" value="4.40785e-19"/>
          <Constant key="Parameter_4159" name="c__gal1p_tot" value="0.001"/>
          <Constant key="Parameter_4158" name="c__glc1p_tot" value="0.012"/>
          <Constant key="Parameter_4157" name="c__udpgal_tot" value="0.11"/>
          <Constant key="Parameter_4156" name="c__udpglc_tot" value="0.34"/>
        </ListOfConstants>
        <KineticLaw function="Function_55">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_458">
              <SourceParameter reference="Compartment_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_459">
              <SourceParameter reference="ModelValue_96"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_460">
              <SourceParameter reference="ModelValue_93"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_461">
              <SourceParameter reference="Metabolite_75"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_462">
              <SourceParameter reference="ModelValue_31"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_463">
              <SourceParameter reference="Metabolite_17"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_464">
              <SourceParameter reference="ModelValue_34"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_465">
              <SourceParameter reference="Metabolite_23"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_466">
              <SourceParameter reference="ModelValue_35"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_467">
              <SourceParameter reference="Metabolite_71"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_468">
              <SourceParameter reference="ModelValue_27"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_16" name="Galactose-1-phosphate uridyl transferase M1 [c__]" reversible="true" fast="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:bqbiol="http://biomodels.net/biology-qualifiers/"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_16">
    <bqbiol:hasProperty>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/omim/230400"/>
      </rdf:Bag>
    </bqbiol:hasProperty>
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000176"/>
        <rdf:li rdf:resource="http://identifiers.org/ec-code/2.7.7.12"/>
        <rdf:li rdf:resource="http://identifiers.org/kegg.reaction/R00955"/>
        <rdf:li rdf:resource="http://identifiers.org/rhea/13992"/>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P07902"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_33" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_71" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_17" stoichiometry="1"/>
          <Product metabolite="Metabolite_59" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_29" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_25" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_75" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_81" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_69" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_23" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4155" name="c__GALT_Vb" value="1.71128e-18"/>
          <Constant key="Parameter_4154" name="c__GALT_Vf" value="4.40785e-19"/>
          <Constant key="Parameter_4153" name="c__gal1p_tot" value="0.001"/>
          <Constant key="Parameter_4152" name="c__glc1p_tot" value="0.012"/>
          <Constant key="Parameter_4151" name="c__udpgal_tot" value="0.11"/>
          <Constant key="Parameter_4150" name="c__udpglc_tot" value="0.34"/>
        </ListOfConstants>
        <KineticLaw function="Function_56">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_480">
              <SourceParameter reference="Compartment_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_481">
              <SourceParameter reference="ModelValue_96"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_482">
              <SourceParameter reference="ModelValue_93"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_483">
              <SourceParameter reference="Metabolite_33"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_484">
              <SourceParameter reference="ModelValue_31"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_485">
              <SourceParameter reference="Metabolite_17"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_486">
              <SourceParameter reference="ModelValue_34"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_487">
              <SourceParameter reference="Metabolite_59"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_488">
              <SourceParameter reference="ModelValue_35"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_489">
              <SourceParameter reference="Metabolite_71"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_490">
              <SourceParameter reference="ModelValue_27"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_17" name="Galactose-1-phosphate uridyl transferase M2 [c__]" reversible="true" fast="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:bqbiol="http://biomodels.net/biology-qualifiers/"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_17">
    <bqbiol:hasProperty>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/omim/230400"/>
      </rdf:Bag>
    </bqbiol:hasProperty>
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000176"/>
        <rdf:li rdf:resource="http://identifiers.org/ec-code/2.7.7.12"/>
        <rdf:li rdf:resource="http://identifiers.org/kegg.reaction/R00955"/>
        <rdf:li rdf:resource="http://identifiers.org/rhea/13992"/>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P07902"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_75" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_81" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_69" stoichiometry="1"/>
          <Product metabolite="Metabolite_23" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_29" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_25" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_33" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_71" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_17" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_59" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4149" name="c__GALT_Vb" value="1.71128e-18"/>
          <Constant key="Parameter_4148" name="c__GALT_Vf" value="4.40785e-19"/>
          <Constant key="Parameter_4147" name="c__gal1p_tot" value="0.001"/>
          <Constant key="Parameter_4146" name="c__glc1p_tot" value="0.012"/>
          <Constant key="Parameter_4145" name="c__udpgal_tot" value="0.11"/>
          <Constant key="Parameter_4144" name="c__udpglc_tot" value="0.34"/>
        </ListOfConstants>
        <KineticLaw function="Function_57">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_502">
              <SourceParameter reference="Compartment_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_503">
              <SourceParameter reference="ModelValue_96"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_504">
              <SourceParameter reference="ModelValue_93"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_505">
              <SourceParameter reference="Metabolite_75"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_506">
              <SourceParameter reference="ModelValue_31"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_507">
              <SourceParameter reference="Metabolite_69"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_508">
              <SourceParameter reference="ModelValue_34"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_509">
              <SourceParameter reference="Metabolite_23"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_510">
              <SourceParameter reference="ModelValue_35"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_511">
              <SourceParameter reference="Metabolite_81"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_512">
              <SourceParameter reference="ModelValue_27"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_18" name="Galactose-1-phosphate uridyl transferase M3 [c__]" reversible="true" fast="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:bqbiol="http://biomodels.net/biology-qualifiers/"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_18">
    <bqbiol:hasProperty>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/omim/230400"/>
      </rdf:Bag>
    </bqbiol:hasProperty>
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000176"/>
        <rdf:li rdf:resource="http://identifiers.org/ec-code/2.7.7.12"/>
        <rdf:li rdf:resource="http://identifiers.org/kegg.reaction/R00955"/>
        <rdf:li rdf:resource="http://identifiers.org/rhea/13992"/>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P07902"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_33" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_81" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_69" stoichiometry="1"/>
          <Product metabolite="Metabolite_59" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_29" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_25" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_75" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_71" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_17" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_23" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4143" name="c__GALT_Vb" value="1.71128e-18"/>
          <Constant key="Parameter_4142" name="c__GALT_Vf" value="4.40785e-19"/>
          <Constant key="Parameter_4141" name="c__gal1p_tot" value="0.001"/>
          <Constant key="Parameter_4140" name="c__glc1p_tot" value="0.012"/>
          <Constant key="Parameter_4139" name="c__udpgal_tot" value="0.11"/>
          <Constant key="Parameter_4138" name="c__udpglc_tot" value="0.34"/>
        </ListOfConstants>
        <KineticLaw function="Function_58">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_524">
              <SourceParameter reference="Compartment_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_525">
              <SourceParameter reference="ModelValue_96"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_526">
              <SourceParameter reference="ModelValue_93"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_527">
              <SourceParameter reference="Metabolite_33"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_528">
              <SourceParameter reference="ModelValue_31"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_529">
              <SourceParameter reference="Metabolite_69"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_530">
              <SourceParameter reference="ModelValue_34"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_531">
              <SourceParameter reference="Metabolite_59"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_532">
              <SourceParameter reference="ModelValue_35"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_533">
              <SourceParameter reference="Metabolite_81"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_534">
              <SourceParameter reference="ModelValue_27"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_19" name="UDP-glucose 4-epimerase [c__]" reversible="true" fast="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:bqbiol="http://biomodels.net/biology-qualifiers/"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_19">
    <bqbiol:hasProperty>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/omim/230350"/>
      </rdf:Bag>
    </bqbiol:hasProperty>
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000176"/>
        <rdf:li rdf:resource="http://identifiers.org/ec-code/5.1.3.2"/>
        <rdf:li rdf:resource="http://identifiers.org/kegg.reaction/R00291"/>
        <rdf:li rdf:resource="http://identifiers.org/rhea/22171"/>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q14376"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_71" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_23" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_81" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_59" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4137" name="c__GALE_Vb" value="8.7631e-17"/>
          <Constant key="Parameter_4136" name="c__GALE_Vf" value="8.93836e-17"/>
          <Constant key="Parameter_4135" name="c__udpgal_tot" value="0.11"/>
          <Constant key="Parameter_4134" name="c__udpglc_tot" value="0.34"/>
        </ListOfConstants>
        <KineticLaw function="Function_59">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_395">
              <SourceParameter reference="Compartment_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_254">
              <SourceParameter reference="ModelValue_105"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_456">
              <SourceParameter reference="ModelValue_109"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_457">
              <SourceParameter reference="Metabolite_23"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_546">
              <SourceParameter reference="ModelValue_35"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_547">
              <SourceParameter reference="Metabolite_71"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_548">
              <SourceParameter reference="ModelValue_27"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_20" name="UDP-glucose 4-epimerase M [c__]" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_81" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_59" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_71" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_23" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4133" name="c__GALE_Vb" value="8.7631e-17"/>
          <Constant key="Parameter_4132" name="c__GALE_Vf" value="8.93836e-17"/>
          <Constant key="Parameter_4131" name="c__udpgal_tot" value="0.11"/>
          <Constant key="Parameter_4130" name="c__udpglc_tot" value="0.34"/>
        </ListOfConstants>
        <KineticLaw function="Function_60">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_556">
              <SourceParameter reference="Compartment_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_557">
              <SourceParameter reference="ModelValue_105"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_558">
              <SourceParameter reference="ModelValue_109"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_559">
              <SourceParameter reference="Metabolite_59"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_560">
              <SourceParameter reference="ModelValue_35"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_561">
              <SourceParameter reference="Metabolite_81"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_562">
              <SourceParameter reference="ModelValue_27"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_21" name="UDP-glucose pyrophosphorylase [c__]" reversible="true" fast="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_21">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000176"/>
        <rdf:li rdf:resource="http://identifiers.org/ec-code/2.7.7.9"/>
        <rdf:li rdf:resource="http://identifiers.org/kegg.reaction/R00289"/>
        <rdf:li rdf:resource="http://identifiers.org/rhea/19892"/>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q16851"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_17" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_29" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_57" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_71" stoichiometry="1"/>
          <Product metabolite="Metabolite_13" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_69" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_81" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_75" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_33" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_23" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_59" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4129" name="c__UGP_Vb" value="4.66115e-15"/>
          <Constant key="Parameter_4128" name="c__UGP_Vf" value="2.49851e-15"/>
          <Constant key="Parameter_4127" name="c__glc1p_tot" value="0.012"/>
          <Constant key="Parameter_4126" name="c__udpglc_tot" value="0.34"/>
        </ListOfConstants>
        <KineticLaw function="Function_61">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_570">
              <SourceParameter reference="Compartment_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_571">
              <SourceParameter reference="ModelValue_125"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_572">
              <SourceParameter reference="ModelValue_121"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_573">
              <SourceParameter reference="Metabolite_17"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_574">
              <SourceParameter reference="ModelValue_34"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_575">
              <SourceParameter reference="Metabolite_71"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_576">
              <SourceParameter reference="ModelValue_27"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_22" name="UDP-glucose pyrophosphorylase M [c__]" reversible="true" fast="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_22">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000176"/>
        <rdf:li rdf:resource="http://identifiers.org/ec-code/2.7.7.9"/>
        <rdf:li rdf:resource="http://identifiers.org/kegg.reaction/R00289"/>
        <rdf:li rdf:resource="http://identifiers.org/rhea/19892"/>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q16851"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_69" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_29" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_57" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_81" stoichiometry="1"/>
          <Product metabolite="Metabolite_13" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_17" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_71" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_75" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_33" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_23" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_59" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4125" name="c__UGP_Vb" value="4.66115e-15"/>
          <Constant key="Parameter_4124" name="c__UGP_Vf" value="2.49851e-15"/>
          <Constant key="Parameter_4123" name="c__glc1p_tot" value="0.012"/>
          <Constant key="Parameter_4122" name="c__udpglc_tot" value="0.34"/>
        </ListOfConstants>
        <KineticLaw function="Function_62">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_584">
              <SourceParameter reference="Compartment_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_585">
              <SourceParameter reference="ModelValue_125"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_586">
              <SourceParameter reference="ModelValue_121"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_587">
              <SourceParameter reference="Metabolite_69"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_588">
              <SourceParameter reference="ModelValue_34"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_589">
              <SourceParameter reference="Metabolite_81"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_590">
              <SourceParameter reference="ModelValue_27"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_23" name="UDP-galactose pyrophosphorylase [c__]" reversible="true" fast="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_23">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000176"/>
        <rdf:li rdf:resource="http://identifiers.org/ec-code/2.7.7.10"/>
        <rdf:li rdf:resource="http://identifiers.org/kegg.reaction/R00502"/>
        <rdf:li rdf:resource="http://identifiers.org/rhea/14212"/>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q16851"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_75" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_29" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_57" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_23" stoichiometry="1"/>
          <Product metabolite="Metabolite_13" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_17" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_69" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_71" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_81" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_33" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_59" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4121" name="c__UGALP_Vb" value="5.18758e-19"/>
          <Constant key="Parameter_4120" name="c__UGALP_Vf" value="7.1624e-20"/>
          <Constant key="Parameter_4119" name="c__gal1p_tot" value="0.001"/>
          <Constant key="Parameter_4118" name="c__udpgal_tot" value="0.11"/>
        </ListOfConstants>
        <KineticLaw function="Function_63">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_598">
              <SourceParameter reference="Compartment_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_599">
              <SourceParameter reference="ModelValue_127"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_600">
              <SourceParameter reference="ModelValue_129"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_601">
              <SourceParameter reference="Metabolite_75"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_602">
              <SourceParameter reference="ModelValue_31"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_603">
              <SourceParameter reference="Metabolite_23"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_604">
              <SourceParameter reference="ModelValue_35"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_24" name="UDP-galactose pyrophosphorylase M [c__]" reversible="true" fast="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_24">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000176"/>
        <rdf:li rdf:resource="http://identifiers.org/ec-code/2.7.7.10"/>
        <rdf:li rdf:resource="http://identifiers.org/kegg.reaction/R00502"/>
        <rdf:li rdf:resource="http://identifiers.org/rhea/14212"/>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q16851"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_33" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_29" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_57" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_59" stoichiometry="1"/>
          <Product metabolite="Metabolite_13" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_17" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_69" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_71" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_81" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_75" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_23" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4117" name="c__UGALP_Vb" value="5.18758e-19"/>
          <Constant key="Parameter_4116" name="c__UGALP_Vf" value="7.1624e-20"/>
          <Constant key="Parameter_4115" name="c__gal1p_tot" value="0.001"/>
          <Constant key="Parameter_4114" name="c__udpgal_tot" value="0.11"/>
        </ListOfConstants>
        <KineticLaw function="Function_64">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_612">
              <SourceParameter reference="Compartment_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_613">
              <SourceParameter reference="ModelValue_127"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_614">
              <SourceParameter reference="ModelValue_129"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_615">
              <SourceParameter reference="Metabolite_33"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_616">
              <SourceParameter reference="ModelValue_31"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_617">
              <SourceParameter reference="Metabolite_59"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_618">
              <SourceParameter reference="ModelValue_35"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_25" name="Pyrophosphatase [c__]" reversible="false" fast="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_25">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000176"/>
        <rdf:li rdf:resource="http://identifiers.org/ec-code/3.6.1.1"/>
        <rdf:li rdf:resource="http://identifiers.org/kegg.reaction/R00004"/>
        <rdf:li rdf:resource="http://identifiers.org/rhea/24579"/>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/Q15181"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_13" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_73" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_83" stoichiometry="2"/>
          <Product metabolite="Metabolite_57" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4113" name="PPASE_k_ppi" value="0.07"/>
          <Constant key="Parameter_4112" name="PPASE_n" value="4"/>
          <Constant key="Parameter_4111" name="c__PPASE_Vmax" value="3.80277e-14"/>
        </ListOfConstants>
        <KineticLaw function="Function_65">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_392">
              <SourceParameter reference="ModelValue_131"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_393">
              <SourceParameter reference="ModelValue_132"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_626">
              <SourceParameter reference="Compartment_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_627">
              <SourceParameter reference="ModelValue_134"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_628">
              <SourceParameter reference="Metabolite_13"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_26" name="ATP:UDP phosphotransferase [c__]" reversible="true" fast="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_26">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000176"/>
        <rdf:li rdf:resource="http://identifiers.org/ec-code/2.7.4.6"/>
        <rdf:li rdf:resource="http://identifiers.org/kegg.reaction/R00156"/>
        <rdf:li rdf:resource="http://identifiers.org/rhea/25101"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_27" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_25" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_49" stoichiometry="1"/>
          <Product metabolite="Metabolite_29" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4110" name="NDKU_k_adp" value="0.042"/>
          <Constant key="Parameter_4109" name="NDKU_k_atp" value="1.33"/>
          <Constant key="Parameter_4108" name="NDKU_k_udp" value="0.19"/>
          <Constant key="Parameter_4107" name="NDKU_k_utp" value="27"/>
          <Constant key="Parameter_4106" name="NDKU_keq" value="1"/>
          <Constant key="Parameter_4105" name="c__NDKU_Vmax" value="1.52111e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_66">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_640">
              <SourceParameter reference="ModelValue_138"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_641">
              <SourceParameter reference="ModelValue_137"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_642">
              <SourceParameter reference="ModelValue_140"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_643">
              <SourceParameter reference="ModelValue_139"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_644">
              <SourceParameter reference="ModelValue_136"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_645">
              <SourceParameter reference="Compartment_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_646">
              <SourceParameter reference="ModelValue_142"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_647">
              <SourceParameter reference="Metabolite_49"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_648">
              <SourceParameter reference="Metabolite_27"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_649">
              <SourceParameter reference="Metabolite_25"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_650">
              <SourceParameter reference="Metabolite_29"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_27" name="Phosphoglucomutase-1 [c__]" reversible="true" fast="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:bqbiol="http://biomodels.net/biology-qualifiers/"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_27">
    <bqbiol:hasProperty>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/omim/612934"/>
      </rdf:Bag>
    </bqbiol:hasProperty>
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000176"/>
        <rdf:li rdf:resource="http://identifiers.org/ec-code/5.4.2.2"/>
        <rdf:li rdf:resource="http://identifiers.org/kegg.reaction/R00959"/>
        <rdf:li rdf:resource="http://identifiers.org/rhea/23539"/>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P36871"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_17" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_47" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_69" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_67" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4104" name="c__PGM1_Vb" value="3.50703e-15"/>
          <Constant key="Parameter_4103" name="c__PGM1_Vf" value="3.50703e-15"/>
          <Constant key="Parameter_4102" name="c__glc1p_tot" value="0.012"/>
          <Constant key="Parameter_4101" name="c__glc6p_tot" value="0.12"/>
        </ListOfConstants>
        <KineticLaw function="Function_67">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_638">
              <SourceParameter reference="Compartment_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_345">
              <SourceParameter reference="ModelValue_148"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_454">
              <SourceParameter reference="ModelValue_152"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_637">
              <SourceParameter reference="Metabolite_17"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_662">
              <SourceParameter reference="ModelValue_34"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_663">
              <SourceParameter reference="Metabolite_47"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_664">
              <SourceParameter reference="ModelValue_30"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_28" name="Phosphoglucomutase-1 M [c__]" reversible="true" fast="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:bqbiol="http://biomodels.net/biology-qualifiers/"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_28">
    <bqbiol:hasProperty>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/omim/612934"/>
      </rdf:Bag>
    </bqbiol:hasProperty>
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000176"/>
        <rdf:li rdf:resource="http://identifiers.org/ec-code/5.4.2.2"/>
        <rdf:li rdf:resource="http://identifiers.org/kegg.reaction/R00959"/>
        <rdf:li rdf:resource="http://identifiers.org/rhea/23539"/>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P36871"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_69" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_67" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_17" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_47" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4100" name="c__PGM1_Vb" value="3.50703e-15"/>
          <Constant key="Parameter_4099" name="c__PGM1_Vf" value="3.50703e-15"/>
          <Constant key="Parameter_4098" name="c__glc1p_tot" value="0.012"/>
          <Constant key="Parameter_4097" name="c__glc6p_tot" value="0.12"/>
        </ListOfConstants>
        <KineticLaw function="Function_68">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_672">
              <SourceParameter reference="Compartment_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_673">
              <SourceParameter reference="ModelValue_148"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_674">
              <SourceParameter reference="ModelValue_152"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_675">
              <SourceParameter reference="Metabolite_69"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_676">
              <SourceParameter reference="ModelValue_34"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_677">
              <SourceParameter reference="Metabolite_67"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_678">
              <SourceParameter reference="ModelValue_30"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_29" name="Glycolysis [c__]" reversible="true" fast="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_29">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000176"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_47" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_45" stoichiometry="5"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_83" stoichiometry="1"/>
          <Product metabolite="Metabolite_53" stoichiometry="6"/>
          <Product metabolite="Metabolite_73" stoichiometry="5"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4096" name="GLY_k_glc6p" value="0.12"/>
          <Constant key="Parameter_4095" name="GLY_k_p" value="0.2"/>
          <Constant key="Parameter_4094" name="c__GLY_Vmax" value="1.90139e-15"/>
        </ListOfConstants>
        <KineticLaw function="Function_69">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_636">
              <SourceParameter reference="ModelValue_154"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_686">
              <SourceParameter reference="ModelValue_155"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_687">
              <SourceParameter reference="Compartment_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_688">
              <SourceParameter reference="ModelValue_157"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_689">
              <SourceParameter reference="Metabolite_47"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_690">
              <SourceParameter reference="Metabolite_83"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_30" name="Glycolysis M [c__]" reversible="false" fast="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_30">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000176"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_67" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_45" stoichiometry="5"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_83" stoichiometry="1"/>
          <Product metabolite="Metabolite_53" stoichiometry="6"/>
          <Product metabolite="Metabolite_73" stoichiometry="5"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4093" name="GLY_k_glc6p" value="0.12"/>
          <Constant key="Parameter_4092" name="GLY_k_p" value="0.2"/>
          <Constant key="Parameter_4091" name="c__GLY_Vmax" value="1.90139e-15"/>
        </ListOfConstants>
        <KineticLaw function="Function_70">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_697">
              <SourceParameter reference="ModelValue_154"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_698">
              <SourceParameter reference="ModelValue_155"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_699">
              <SourceParameter reference="Compartment_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_700">
              <SourceParameter reference="ModelValue_157"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_701">
              <SourceParameter reference="Metabolite_67"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_702">
              <SourceParameter reference="Metabolite_83"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_31" name="Glycosyltransferase galactose [c__]" reversible="false" fast="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_31">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000176"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_23" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_21" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_25" stoichiometry="1"/>
          <Product metabolite="Metabolite_19" stoichiometry="1"/>
          <Product metabolite="Metabolite_57" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_59" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4090" name="c__GTFGAL_Vf" value="3.98385e-18"/>
          <Constant key="Parameter_4089" name="c__udpgal_tot" value="0.11"/>
        </ListOfConstants>
        <KineticLaw function="Function_71">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_391">
              <SourceParameter reference="Compartment_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_634">
              <SourceParameter reference="ModelValue_162"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_709">
              <SourceParameter reference="Metabolite_23"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_710">
              <SourceParameter reference="ModelValue_35"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_32" name="Glycosyltransferase galactose M [c__]" reversible="false" fast="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_32">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000176"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_59" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_21" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_25" stoichiometry="1"/>
          <Product metabolite="Metabolite_37" stoichiometry="1"/>
          <Product metabolite="Metabolite_57" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_23" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4088" name="c__GTFGAL_Vf" value="3.98385e-18"/>
          <Constant key="Parameter_4087" name="c__udpgal_tot" value="0.11"/>
        </ListOfConstants>
        <KineticLaw function="Function_72">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_715">
              <SourceParameter reference="Compartment_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_716">
              <SourceParameter reference="ModelValue_162"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_717">
              <SourceParameter reference="Metabolite_59"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_718">
              <SourceParameter reference="ModelValue_35"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_33" name="Glycosyltransferase glucose [c__]" reversible="false" fast="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_33">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000176"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_71" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_21" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_25" stoichiometry="1"/>
          <Product metabolite="Metabolite_39" stoichiometry="1"/>
          <Product metabolite="Metabolite_57" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_81" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4086" name="c__GTFGLC_Vf" value="0"/>
          <Constant key="Parameter_4085" name="c__udpglc_tot" value="0.34"/>
        </ListOfConstants>
        <KineticLaw function="Function_73">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_723">
              <SourceParameter reference="Compartment_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_724">
              <SourceParameter reference="ModelValue_164"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_725">
              <SourceParameter reference="Metabolite_71"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_726">
              <SourceParameter reference="ModelValue_27"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_34" name="Glycosyltransferase glucose M [c__]" reversible="false" fast="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_34">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000176"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_81" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_21" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_25" stoichiometry="1"/>
          <Product metabolite="Metabolite_79" stoichiometry="1"/>
          <Product metabolite="Metabolite_57" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_71" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4084" name="c__GTFGLC_Vf" value="0"/>
          <Constant key="Parameter_4083" name="c__udpglc_tot" value="0.34"/>
        </ListOfConstants>
        <KineticLaw function="Function_74">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_731">
              <SourceParameter reference="Compartment_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_732">
              <SourceParameter reference="ModelValue_164"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_733">
              <SourceParameter reference="Metabolite_81"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_734">
              <SourceParameter reference="ModelValue_27"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_35" name="H2O M transport [e__]" reversible="true" fast="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_35">
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000185"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_15" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_51" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_4082" name="H2OT_k" value="1"/>
          <Constant key="Parameter_4081" name="c__H2OT_Vmax" value="1.457e-14"/>
        </ListOfConstants>
        <KineticLaw function="Function_75">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_739">
              <SourceParameter reference="ModelValue_166"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_740">
              <SourceParameter reference="ModelValue_167"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_741">
              <SourceParameter reference="Metabolite_15"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_742">
              <SourceParameter reference="Metabolite_51"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_36" name="galactose transport [e__]" reversible="true" fast="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:bqbiol="http://biomodels.net/biology-qualifiers/"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_36">
    <bqbiol:hasProperty>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/omim/OMIM:227810"/>
      </rdf:Bag>
    </bqbiol:hasProperty>
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000185"/>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P11168"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_31" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_35" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_43" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_61" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4080" name="c__GLUT2_Vb" value="1.33645e-19"/>
          <Constant key="Parameter_4079" name="c__GLUT2_Vf" value="1.33645e-19"/>
          <Constant key="Parameter_4078" name="c__gal_tot" value="0.00012"/>
          <Constant key="Parameter_4077" name="e__gal_tot" value="0.00012"/>
        </ListOfConstants>
        <KineticLaw function="Function_76">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_749">
              <SourceParameter reference="ModelValue_172"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_750">
              <SourceParameter reference="ModelValue_174"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_751">
              <SourceParameter reference="Metabolite_35"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_752">
              <SourceParameter reference="ModelValue_25"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_753">
              <SourceParameter reference="Metabolite_31"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_754">
              <SourceParameter reference="ModelValue_26"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_37" name="galactose transport M [e__]" reversible="true" fast="false">
        <MiriamAnnotation>
<rdf:RDF
   xmlns:CopasiMT="http://www.copasi.org/RDF/MiriamTerms#"
   xmlns:bqbiol="http://biomodels.net/biology-qualifiers/"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Reaction_37">
    <bqbiol:hasProperty>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/omim/227810"/>
      </rdf:Bag>
    </bqbiol:hasProperty>
    <CopasiMT:is>
      <rdf:Bag>
        <rdf:li rdf:resource="http://identifiers.org/biomodels.sbo/SBO:0000185"/>
        <rdf:li rdf:resource="http://identifiers.org/uniprot/P11168"/>
      </rdf:Bag>
    </CopasiMT:is>
  </rdf:Description>
</rdf:RDF>

        </MiriamAnnotation>
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_43" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_61" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_31" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_35" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_4076" name="c__GLUT2_Vb" value="1.33645e-19"/>
          <Constant key="Parameter_4075" name="c__GLUT2_Vf" value="1.33645e-19"/>
          <Constant key="Parameter_4074" name="c__gal_tot" value="0.00012"/>
          <Constant key="Parameter_4073" name="e__gal_tot" value="0.00012"/>
        </ListOfConstants>
        <KineticLaw function="Function_77">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_761">
              <SourceParameter reference="ModelValue_172"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_762">
              <SourceParameter reference="ModelValue_174"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_763">
              <SourceParameter reference="Metabolite_61"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_764">
              <SourceParameter reference="ModelValue_25"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_765">
              <SourceParameter reference="Metabolite_43"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_766">
              <SourceParameter reference="ModelValue_26"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
    </ListOfReactions>
    <ListOfModelParameterSets activeSet="ModelParameterSet_1">
      <ModelParameterSet key="ModelParameterSet_1" name="Initial State">
        <ModelParameterGroup cn="String=Initial Time" type="Group">
          <ModelParameter cn="CN=Root,Model=galactose_28" value="0" type="Model" simulationType="time"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Compartment Sizes" type="Group">
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[hepatocyte]" value="5.875e-15" type="Compartment" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol]" value="2.35e-15" type="Compartment" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[external]" value="5.875e-15" type="Compartment" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[plasma membrane]" value="6.25e-10" type="Compartment" simulationType="assignment"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Species Values" type="Group">
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[hepatocyte],Vector=Metabolites[water M*]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[pyrophosphate]" value="11321626.5652" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[D-glucose 1-phophate]" value="16982439.84780001" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[Acceptor-galactose]" value="0" type="Species" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[Acceptor (glc/gal)]" value="0" type="Species" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[UDP-D-galactose]" value="155672365.2715" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[UDP]" value="127368298.8585" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[ATP]" value="3821048965.755001" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[UTP]" value="382104896.5755001" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[D-galactose 1-phosphate M*]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[D-galactose]" value="169824.398478" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[Acceptor-galactose M*]" value="0" type="Species" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[Acceptor-glucose]" value="0" type="Species" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[D-galactitol M*]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[O2]" value="0" type="Species" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[D-glucose 6-phosphate]" value="169824398.478" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[ADP]" value="1698243984.78" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[CO2]" value="0" type="Species" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[NADP]" value="141520332.065" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[H+]" value="0" type="Species" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[UDP-D-galactose M*]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[D-galactose M*]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[D-galactitol]" value="1415203.32065" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[NADPH]" value="141520332.065" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[D-glucose 6-phosphate M*]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[D-glucose 1-phophate M*]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[UDP-D-glucose]" value="481169129.0210001" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[water]" value="0" type="Species" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[D-galactose 1-phosphate]" value="1415203.32065" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[H2]" value="0" type="Species" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[Acceptor-glucose M*]" value="0" type="Species" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[UDP-D-glucose M*]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[phosphate]" value="7076016603.250001" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[external],Vector=Metabolites[water M*]" value="0" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[external],Vector=Metabolites[D-galactose]" value="424560.996195" type="Species" simulationType="reactions"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Compartments[external],Vector=Metabolites[D-galactose M*]" value="0" type="Species" simulationType="reactions"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Initial Global Quantities" type="Group">
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[metabolic scaling factor]" value="0.31" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[width hepatocyte]" value="9.4e-06" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[length hepatocyte]" value="2.5e-05" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[cytosolic fraction of hepatocyte]" value="0.4" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[Nf]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[type of galactosemia]" value="0" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[reference protein amount]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[parenchymal fraction of liver]" value="0.8" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[volume external compartment]" value="5.875e-15" type="ModelValue" simulationType="fixed">
            <InitialExpression>
              &lt;CN=Root,Model=galactose_28,Vector=Values[volume hepatocyte],Reference=InitialValue&gt;
            </InitialExpression>
          </ModelParameter>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[volume cytosol]" value="2.35e-15" type="ModelValue" simulationType="fixed">
            <InitialExpression>
              &lt;CN=Root,Model=galactose_28,Vector=Values[cytosolic fraction of hepatocyte],Reference=InitialValue&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[volume hepatocyte],Reference=InitialValue&gt;
            </InitialExpression>
          </ModelParameter>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[area plasma membrane]" value="6.25e-10" type="ModelValue" simulationType="fixed">
            <InitialExpression>
              &lt;CN=Root,Model=galactose_28,Vector=Values[length hepatocyte],Reference=InitialValue&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[length hepatocyte],Reference=InitialValue&gt;
            </InitialExpression>
          </ModelParameter>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[volume hepatocyte]" value="5.875e-15" type="ModelValue" simulationType="fixed">
            <InitialExpression>
              &lt;CN=Root,Model=galactose_28,Vector=Values[length hepatocyte],Reference=InitialValue&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[length hepatocyte],Reference=InitialValue&gt;*&lt;CN=Root,Model=galactose_28,Vector=Values[width hepatocyte],Reference=InitialValue&gt;
            </InitialExpression>
          </ModelParameter>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__gal_tot]" value="0.00012" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[e__gal_tot]" value="0.00012" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__udpglc_tot]" value="0.34" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[ADP balance]" value="3.9" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[Phosphate balance]" value="17.539" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__glc6p_tot]" value="0.12" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__gal1p_tot]" value="0.0009999999999999998" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__scale]" value="1.82125e-15" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__galtol_tot]" value="0.0009999999999999998" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__glc1p_tot]" value="0.012" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__udpgal_tot]" value="0.11" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[UDP balance]" value="0.8099999999999999" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[NADP balance]" value="0.2" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[GALK_PA]" value="0.024" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[GALK_keq]" value="50" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[GALK_k_gal1p]" value="1.5" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[GALK_k_adp]" value="0.8" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[GALK_ki_gal1p]" value="5.3" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[GALK_kcat]" value="8.699999999999999" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[GALK_k_gal]" value="0.14" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[GALK_k_atp]" value="0.034" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__GALK_P]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__GALK_V]" value="9.742956830412509e-16" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__GALK_Vb]" value="2.338309639299002e-20" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__GALK_Vmax]" value="3.80277e-16" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__GALK_dm]" value="81.98235574229692" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__GALK_Vf]" value="3.156718013053654e-19" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[IMP_f]" value="0.05" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[IMP_k_gal1p]" value="0.35" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__IMP_P]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__IMP_dm]" value="1.002857142857143" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__IMP_Vf]" value="5.417051282051282e-20" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__IMP_Vmax]" value="1.901385e-17" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[ATPS_f]" value="100" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[ATPS_keq]" value="0.58" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[ATPS_k_adp]" value="0.1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[ATPS_k_atp]" value="0.5" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[ATPS_k_phos]" value="0.1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__ATPS_P]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__ATPS_Vmax]" value="3.80277e-14" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[ALDR_f]" value="1000000" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[ALDR_keq]" value="4" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[ALDR_k_gal]" value="40" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[ALDR_k_galtol]" value="40" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[ALDR_k_nadp]" value="0.1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[ALDR_k_nadph]" value="0.1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__ALDR_P]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__ALDR_Vb]" value="7.922289617260477e-16" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__ALDR_V]" value="3.168915846904192e-11" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__ALDR_Vmax]" value="3.80277e-10" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__ALDR_dm]" value="3.000056" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__ALDR_Vf]" value="3.802699016285031e-16" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[NADPR_f]" value="1e-10" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[NADPR_keq]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[NADPR_k_nadp]" value="0.015" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[NADPR_ki_nadph]" value="0.01" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__NADPR_P]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__NADPR_Vmax]" value="3.80277e-20" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[GALT_f]" value="0.01" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[GALT_keq]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[GALT_k_glc1p]" value="0.37" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[GALT_k_udpgal]" value="0.5" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[GALT_ki_utp]" value="0.13" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[GALT_ki_udp]" value="0.35" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[GALT_vm]" value="804" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[GALT_k_gal1p]" value="1.25" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[GALT_k_udpglc]" value="0.43" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__GALT_P]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__GALT_Vf]" value="4.407846492208454e-19" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__GALT_V]" value="1.296425438884839e-15" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__GALT_Vmax]" value="3.05742708e-15" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__GALT_Vb]" value="1.711281579327988e-18" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__GALT_dm]" value="4.387630986938894" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[GALE_f]" value="0.3" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[GALE_PA]" value="0.0278" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[GALE_kcat]" value="36" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[GALE_keq]" value="0.33" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[GALE_k_udpglc]" value="0.06900000000000001" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[GALE_k_udpgal]" value="0.3" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__GALE_P]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__GALE_Vb]" value="8.763095132396961e-17" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__GALE_V]" value="2.628928539719088e-16" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__GALE_Vmax]" value="1.1417436648e-16" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__GALE_dm]" value="6.294202898550724" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__GALE_Vf]" value="8.938357035044901e-17" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[UGP_f]" value="2000" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[UGP_keq]" value="0.45" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[UGP_k_utp]" value="0.5629999999999999" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[UGP_k_glc1p]" value="0.172" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[UGP_k_udpglc]" value="0.049" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[UGP_k_ppi]" value="0.166" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[UGP_k_gal1p]" value="5" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[UGP_k_udpgal]" value="0.42" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[UGP_ki_utp]" value="0.643" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[UGP_ki_udpglc]" value="0.643" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__UGP_P]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__UGP_Vf]" value="2.498511886502129e-15" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__UGP_V]" value="7.711456439821385e-13" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__UGP_Vmax]" value="7.605540000000001e-13" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__UGP_dm]" value="10.18490079862424" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__UGP_Vb]" value="4.66114700362537e-15" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[UGALP_f]" value="0.01" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__UGALP_Vb]" value="5.187582429917176e-19" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__UGALP_V]" value="2.652741015298557e-16" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__UGALP_Vf]" value="7.162400741306102e-20" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[PPASE_f]" value="0.05" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[PPASE_k_ppi]" value="0.07000000000000001" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[PPASE_n]" value="4" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__PPASE_P]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__PPASE_Vmax]" value="3.802770000000001e-14" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[NDKU_f]" value="2" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[NDKU_keq]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[NDKU_k_atp]" value="1.33" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[NDKU_k_adp]" value="0.042" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[NDKU_k_utp]" value="27" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[NDKU_k_udp]" value="0.19" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__NDKU_P]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__NDKU_Vmax]" value="1.521108e-12" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[PGM1_f]" value="50" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[PGM1_keq]" value="10" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[PGM1_k_glc6p]" value="0.67" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[PGM1_k_glc1p]" value="0.045" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__PGM1_P]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__PGM1_Vb]" value="3.507028079834825e-15" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__PGM1_V]" value="2.922523399862354e-13" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__PGM1_Vmax]" value="1.901385e-14" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__PGM1_dm]" value="1.445771144278607" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__PGM1_Vf]" value="3.507028079834825e-15" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[GLY_f]" value="0.1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[GLY_k_glc6p]" value="0.12" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[GLY_k_p]" value="0.2" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__GLY_P]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__GLY_Vmax]" value="1.901385e-15" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[GTF_f]" value="0.02" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[GTF_k_udpgal]" value="0.1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[GTF_k_udpglc]" value="0.1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__GTF_P]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__GTFGAL_Vf]" value="3.983854285714287e-18" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__GTF_Vmax]" value="7.605540000000001e-18" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__GTFGLC_Vf]" value="0" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[H2OT_f]" value="8" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[H2OT_k]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__H2OT_Vmax]" value="1.457e-14" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[GLUT2_f]" value="17" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[GLUT2_k_gal]" value="27.8" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__GLUT2_P]" value="1" type="ModelValue" simulationType="fixed"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__GLUT2_dm]" value="1.000008633093525" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__GLUT2_Vb]" value="1.336445296875135e-19" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__GLUT2_V]" value="1.113704414062612e-15" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__GLUT2_Vf]" value="1.336445296875134e-19" type="ModelValue" simulationType="assignment"/>
          <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Values[c__GLUT2_Vmax]" value="3.096125e-14" type="ModelValue" simulationType="assignment"/>
        </ModelParameterGroup>
        <ModelParameterGroup cn="String=Kinetic Parameters" type="Group">
          <ModelParameterGroup cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactokinase \[c__\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactokinase \[c__\]],ParameterGroup=Parameters,Parameter=c__GALK_Vb" value="2.338309639299002e-20" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__GALK_Vb],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactokinase \[c__\]],ParameterGroup=Parameters,Parameter=c__GALK_Vf" value="3.156718013053654e-19" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__GALK_Vf],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactokinase \[c__\]],ParameterGroup=Parameters,Parameter=c__gal1p_tot" value="0.0009999999999999998" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__gal1p_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactokinase \[c__\]],ParameterGroup=Parameters,Parameter=c__gal_tot" value="0.00012" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__gal_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactokinase M \[c__\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactokinase M \[c__\]],ParameterGroup=Parameters,Parameter=c__GALK_Vb" value="2.338309639299002e-20" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__GALK_Vb],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactokinase M \[c__\]],ParameterGroup=Parameters,Parameter=c__GALK_Vf" value="3.156718013053654e-19" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__GALK_Vf],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactokinase M \[c__\]],ParameterGroup=Parameters,Parameter=c__gal1p_tot" value="0.0009999999999999998" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__gal1p_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactokinase M \[c__\]],ParameterGroup=Parameters,Parameter=c__gal_tot" value="0.00012" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__gal_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=galactose_28,Vector=Reactions[Inositol monophosphatase \[c__\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Inositol monophosphatase \[c__\]],ParameterGroup=Parameters,Parameter=c__IMP_Vf" value="5.417051282051282e-20" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__IMP_Vf],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Inositol monophosphatase \[c__\]],ParameterGroup=Parameters,Parameter=c__gal1p_tot" value="0.0009999999999999998" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__gal1p_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=galactose_28,Vector=Reactions[Inositol monophosphatase M \[c__\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Inositol monophosphatase M \[c__\]],ParameterGroup=Parameters,Parameter=c__IMP_Vf" value="5.417051282051282e-20" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__IMP_Vf],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Inositol monophosphatase M \[c__\]],ParameterGroup=Parameters,Parameter=c__gal1p_tot" value="0.0009999999999999998" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__gal1p_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=galactose_28,Vector=Reactions[ATP synthase \[c__\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[ATP synthase \[c__\]],ParameterGroup=Parameters,Parameter=ATPS_k_adp" value="0.1" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[ATPS_k_adp],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[ATP synthase \[c__\]],ParameterGroup=Parameters,Parameter=ATPS_k_atp" value="0.5" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[ATPS_k_atp],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[ATP synthase \[c__\]],ParameterGroup=Parameters,Parameter=ATPS_k_phos" value="0.1" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[ATPS_k_phos],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[ATP synthase \[c__\]],ParameterGroup=Parameters,Parameter=ATPS_keq" value="0.58" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[ATPS_keq],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[ATP synthase \[c__\]],ParameterGroup=Parameters,Parameter=c__ATPS_Vmax" value="3.80277e-14" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__ATPS_Vmax],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=galactose_28,Vector=Reactions[Aldose reductase \[c__\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Aldose reductase \[c__\]],ParameterGroup=Parameters,Parameter=c__ALDR_Vb" value="7.922289617260477e-16" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__ALDR_Vb],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Aldose reductase \[c__\]],ParameterGroup=Parameters,Parameter=c__ALDR_Vf" value="3.802699016285031e-16" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__ALDR_Vf],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Aldose reductase \[c__\]],ParameterGroup=Parameters,Parameter=c__gal_tot" value="0.00012" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__gal_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Aldose reductase \[c__\]],ParameterGroup=Parameters,Parameter=c__galtol_tot" value="0.0009999999999999998" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__galtol_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=galactose_28,Vector=Reactions[Aldose reductase M \[c__\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Aldose reductase M \[c__\]],ParameterGroup=Parameters,Parameter=c__ALDR_Vb" value="7.922289617260477e-16" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__ALDR_Vb],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Aldose reductase M \[c__\]],ParameterGroup=Parameters,Parameter=c__ALDR_Vf" value="3.802699016285031e-16" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__ALDR_Vf],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Aldose reductase M \[c__\]],ParameterGroup=Parameters,Parameter=c__gal_tot" value="0.00012" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__gal_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Aldose reductase M \[c__\]],ParameterGroup=Parameters,Parameter=c__galtol_tot" value="0.0009999999999999998" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__galtol_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=galactose_28,Vector=Reactions[NADP Reductase \[c__\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[NADP Reductase \[c__\]],ParameterGroup=Parameters,Parameter=NADPR_k_nadp" value="0.015" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[NADPR_k_nadp],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[NADP Reductase \[c__\]],ParameterGroup=Parameters,Parameter=NADPR_keq" value="1" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[NADPR_keq],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[NADP Reductase \[c__\]],ParameterGroup=Parameters,Parameter=NADPR_ki_nadph" value="0.01" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[NADPR_ki_nadph],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[NADP Reductase \[c__\]],ParameterGroup=Parameters,Parameter=c__NADPR_Vmax" value="3.80277e-20" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__NADPR_Vmax],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactose-1-phosphate uridyl transferase \[c__\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactose-1-phosphate uridyl transferase \[c__\]],ParameterGroup=Parameters,Parameter=c__GALT_Vb" value="1.711281579327988e-18" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__GALT_Vb],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactose-1-phosphate uridyl transferase \[c__\]],ParameterGroup=Parameters,Parameter=c__GALT_Vf" value="4.407846492208454e-19" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__GALT_Vf],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactose-1-phosphate uridyl transferase \[c__\]],ParameterGroup=Parameters,Parameter=c__gal1p_tot" value="0.0009999999999999998" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__gal1p_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactose-1-phosphate uridyl transferase \[c__\]],ParameterGroup=Parameters,Parameter=c__glc1p_tot" value="0.012" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__glc1p_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactose-1-phosphate uridyl transferase \[c__\]],ParameterGroup=Parameters,Parameter=c__udpgal_tot" value="0.11" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__udpgal_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactose-1-phosphate uridyl transferase \[c__\]],ParameterGroup=Parameters,Parameter=c__udpglc_tot" value="0.34" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__udpglc_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactose-1-phosphate uridyl transferase M1 \[c__\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactose-1-phosphate uridyl transferase M1 \[c__\]],ParameterGroup=Parameters,Parameter=c__GALT_Vb" value="1.711281579327988e-18" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__GALT_Vb],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactose-1-phosphate uridyl transferase M1 \[c__\]],ParameterGroup=Parameters,Parameter=c__GALT_Vf" value="4.407846492208454e-19" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__GALT_Vf],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactose-1-phosphate uridyl transferase M1 \[c__\]],ParameterGroup=Parameters,Parameter=c__gal1p_tot" value="0.0009999999999999998" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__gal1p_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactose-1-phosphate uridyl transferase M1 \[c__\]],ParameterGroup=Parameters,Parameter=c__glc1p_tot" value="0.012" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__glc1p_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactose-1-phosphate uridyl transferase M1 \[c__\]],ParameterGroup=Parameters,Parameter=c__udpgal_tot" value="0.11" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__udpgal_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactose-1-phosphate uridyl transferase M1 \[c__\]],ParameterGroup=Parameters,Parameter=c__udpglc_tot" value="0.34" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__udpglc_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactose-1-phosphate uridyl transferase M2 \[c__\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactose-1-phosphate uridyl transferase M2 \[c__\]],ParameterGroup=Parameters,Parameter=c__GALT_Vb" value="1.711281579327988e-18" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__GALT_Vb],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactose-1-phosphate uridyl transferase M2 \[c__\]],ParameterGroup=Parameters,Parameter=c__GALT_Vf" value="4.407846492208454e-19" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__GALT_Vf],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactose-1-phosphate uridyl transferase M2 \[c__\]],ParameterGroup=Parameters,Parameter=c__gal1p_tot" value="0.0009999999999999998" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__gal1p_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactose-1-phosphate uridyl transferase M2 \[c__\]],ParameterGroup=Parameters,Parameter=c__glc1p_tot" value="0.012" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__glc1p_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactose-1-phosphate uridyl transferase M2 \[c__\]],ParameterGroup=Parameters,Parameter=c__udpgal_tot" value="0.11" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__udpgal_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactose-1-phosphate uridyl transferase M2 \[c__\]],ParameterGroup=Parameters,Parameter=c__udpglc_tot" value="0.34" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__udpglc_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactose-1-phosphate uridyl transferase M3 \[c__\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactose-1-phosphate uridyl transferase M3 \[c__\]],ParameterGroup=Parameters,Parameter=c__GALT_Vb" value="1.711281579327988e-18" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__GALT_Vb],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactose-1-phosphate uridyl transferase M3 \[c__\]],ParameterGroup=Parameters,Parameter=c__GALT_Vf" value="4.407846492208454e-19" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__GALT_Vf],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactose-1-phosphate uridyl transferase M3 \[c__\]],ParameterGroup=Parameters,Parameter=c__gal1p_tot" value="0.0009999999999999998" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__gal1p_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactose-1-phosphate uridyl transferase M3 \[c__\]],ParameterGroup=Parameters,Parameter=c__glc1p_tot" value="0.012" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__glc1p_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactose-1-phosphate uridyl transferase M3 \[c__\]],ParameterGroup=Parameters,Parameter=c__udpgal_tot" value="0.11" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__udpgal_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Galactose-1-phosphate uridyl transferase M3 \[c__\]],ParameterGroup=Parameters,Parameter=c__udpglc_tot" value="0.34" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__udpglc_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=galactose_28,Vector=Reactions[UDP-glucose 4-epimerase \[c__\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[UDP-glucose 4-epimerase \[c__\]],ParameterGroup=Parameters,Parameter=c__GALE_Vb" value="8.763095132396961e-17" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__GALE_Vb],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[UDP-glucose 4-epimerase \[c__\]],ParameterGroup=Parameters,Parameter=c__GALE_Vf" value="8.938357035044901e-17" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__GALE_Vf],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[UDP-glucose 4-epimerase \[c__\]],ParameterGroup=Parameters,Parameter=c__udpgal_tot" value="0.11" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__udpgal_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[UDP-glucose 4-epimerase \[c__\]],ParameterGroup=Parameters,Parameter=c__udpglc_tot" value="0.34" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__udpglc_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=galactose_28,Vector=Reactions[UDP-glucose 4-epimerase M \[c__\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[UDP-glucose 4-epimerase M \[c__\]],ParameterGroup=Parameters,Parameter=c__GALE_Vb" value="8.763095132396961e-17" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__GALE_Vb],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[UDP-glucose 4-epimerase M \[c__\]],ParameterGroup=Parameters,Parameter=c__GALE_Vf" value="8.938357035044901e-17" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__GALE_Vf],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[UDP-glucose 4-epimerase M \[c__\]],ParameterGroup=Parameters,Parameter=c__udpgal_tot" value="0.11" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__udpgal_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[UDP-glucose 4-epimerase M \[c__\]],ParameterGroup=Parameters,Parameter=c__udpglc_tot" value="0.34" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__udpglc_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=galactose_28,Vector=Reactions[UDP-glucose pyrophosphorylase \[c__\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[UDP-glucose pyrophosphorylase \[c__\]],ParameterGroup=Parameters,Parameter=c__UGP_Vb" value="4.66114700362537e-15" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__UGP_Vb],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[UDP-glucose pyrophosphorylase \[c__\]],ParameterGroup=Parameters,Parameter=c__UGP_Vf" value="2.498511886502129e-15" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__UGP_Vf],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[UDP-glucose pyrophosphorylase \[c__\]],ParameterGroup=Parameters,Parameter=c__glc1p_tot" value="0.012" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__glc1p_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[UDP-glucose pyrophosphorylase \[c__\]],ParameterGroup=Parameters,Parameter=c__udpglc_tot" value="0.34" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__udpglc_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=galactose_28,Vector=Reactions[UDP-glucose pyrophosphorylase M \[c__\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[UDP-glucose pyrophosphorylase M \[c__\]],ParameterGroup=Parameters,Parameter=c__UGP_Vb" value="4.66114700362537e-15" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__UGP_Vb],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[UDP-glucose pyrophosphorylase M \[c__\]],ParameterGroup=Parameters,Parameter=c__UGP_Vf" value="2.498511886502129e-15" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__UGP_Vf],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[UDP-glucose pyrophosphorylase M \[c__\]],ParameterGroup=Parameters,Parameter=c__glc1p_tot" value="0.012" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__glc1p_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[UDP-glucose pyrophosphorylase M \[c__\]],ParameterGroup=Parameters,Parameter=c__udpglc_tot" value="0.34" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__udpglc_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=galactose_28,Vector=Reactions[UDP-galactose pyrophosphorylase \[c__\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[UDP-galactose pyrophosphorylase \[c__\]],ParameterGroup=Parameters,Parameter=c__UGALP_Vb" value="5.187582429917176e-19" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__UGALP_Vb],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[UDP-galactose pyrophosphorylase \[c__\]],ParameterGroup=Parameters,Parameter=c__UGALP_Vf" value="7.162400741306102e-20" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__UGALP_Vf],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[UDP-galactose pyrophosphorylase \[c__\]],ParameterGroup=Parameters,Parameter=c__gal1p_tot" value="0.0009999999999999998" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__gal1p_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[UDP-galactose pyrophosphorylase \[c__\]],ParameterGroup=Parameters,Parameter=c__udpgal_tot" value="0.11" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__udpgal_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=galactose_28,Vector=Reactions[UDP-galactose pyrophosphorylase M \[c__\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[UDP-galactose pyrophosphorylase M \[c__\]],ParameterGroup=Parameters,Parameter=c__UGALP_Vb" value="5.187582429917176e-19" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__UGALP_Vb],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[UDP-galactose pyrophosphorylase M \[c__\]],ParameterGroup=Parameters,Parameter=c__UGALP_Vf" value="7.162400741306102e-20" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__UGALP_Vf],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[UDP-galactose pyrophosphorylase M \[c__\]],ParameterGroup=Parameters,Parameter=c__gal1p_tot" value="0.0009999999999999998" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__gal1p_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[UDP-galactose pyrophosphorylase M \[c__\]],ParameterGroup=Parameters,Parameter=c__udpgal_tot" value="0.11" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__udpgal_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=galactose_28,Vector=Reactions[Pyrophosphatase \[c__\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Pyrophosphatase \[c__\]],ParameterGroup=Parameters,Parameter=PPASE_k_ppi" value="0.07000000000000001" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[PPASE_k_ppi],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Pyrophosphatase \[c__\]],ParameterGroup=Parameters,Parameter=PPASE_n" value="4" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[PPASE_n],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Pyrophosphatase \[c__\]],ParameterGroup=Parameters,Parameter=c__PPASE_Vmax" value="3.802770000000001e-14" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__PPASE_Vmax],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=galactose_28,Vector=Reactions[ATP:UDP phosphotransferase \[c__\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[ATP:UDP phosphotransferase \[c__\]],ParameterGroup=Parameters,Parameter=NDKU_k_adp" value="0.042" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[NDKU_k_adp],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[ATP:UDP phosphotransferase \[c__\]],ParameterGroup=Parameters,Parameter=NDKU_k_atp" value="1.33" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[NDKU_k_atp],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[ATP:UDP phosphotransferase \[c__\]],ParameterGroup=Parameters,Parameter=NDKU_k_udp" value="0.19" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[NDKU_k_udp],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[ATP:UDP phosphotransferase \[c__\]],ParameterGroup=Parameters,Parameter=NDKU_k_utp" value="27" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[NDKU_k_utp],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[ATP:UDP phosphotransferase \[c__\]],ParameterGroup=Parameters,Parameter=NDKU_keq" value="1" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[NDKU_keq],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[ATP:UDP phosphotransferase \[c__\]],ParameterGroup=Parameters,Parameter=c__NDKU_Vmax" value="1.521108e-12" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__NDKU_Vmax],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=galactose_28,Vector=Reactions[Phosphoglucomutase-1 \[c__\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Phosphoglucomutase-1 \[c__\]],ParameterGroup=Parameters,Parameter=c__PGM1_Vb" value="3.507028079834825e-15" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__PGM1_Vb],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Phosphoglucomutase-1 \[c__\]],ParameterGroup=Parameters,Parameter=c__PGM1_Vf" value="3.507028079834825e-15" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__PGM1_Vf],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Phosphoglucomutase-1 \[c__\]],ParameterGroup=Parameters,Parameter=c__glc1p_tot" value="0.012" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__glc1p_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Phosphoglucomutase-1 \[c__\]],ParameterGroup=Parameters,Parameter=c__glc6p_tot" value="0.12" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__glc6p_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=galactose_28,Vector=Reactions[Phosphoglucomutase-1 M \[c__\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Phosphoglucomutase-1 M \[c__\]],ParameterGroup=Parameters,Parameter=c__PGM1_Vb" value="3.507028079834825e-15" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__PGM1_Vb],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Phosphoglucomutase-1 M \[c__\]],ParameterGroup=Parameters,Parameter=c__PGM1_Vf" value="3.507028079834825e-15" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__PGM1_Vf],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Phosphoglucomutase-1 M \[c__\]],ParameterGroup=Parameters,Parameter=c__glc1p_tot" value="0.012" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__glc1p_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Phosphoglucomutase-1 M \[c__\]],ParameterGroup=Parameters,Parameter=c__glc6p_tot" value="0.12" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__glc6p_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=galactose_28,Vector=Reactions[Glycolysis \[c__\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Glycolysis \[c__\]],ParameterGroup=Parameters,Parameter=GLY_k_glc6p" value="0.12" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[GLY_k_glc6p],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Glycolysis \[c__\]],ParameterGroup=Parameters,Parameter=GLY_k_p" value="0.2" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[GLY_k_p],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Glycolysis \[c__\]],ParameterGroup=Parameters,Parameter=c__GLY_Vmax" value="1.901385e-15" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__GLY_Vmax],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=galactose_28,Vector=Reactions[Glycolysis M \[c__\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Glycolysis M \[c__\]],ParameterGroup=Parameters,Parameter=GLY_k_glc6p" value="0.12" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[GLY_k_glc6p],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Glycolysis M \[c__\]],ParameterGroup=Parameters,Parameter=GLY_k_p" value="0.2" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[GLY_k_p],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Glycolysis M \[c__\]],ParameterGroup=Parameters,Parameter=c__GLY_Vmax" value="1.901385e-15" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__GLY_Vmax],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=galactose_28,Vector=Reactions[Glycosyltransferase galactose \[c__\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Glycosyltransferase galactose \[c__\]],ParameterGroup=Parameters,Parameter=c__GTFGAL_Vf" value="3.983854285714287e-18" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__GTFGAL_Vf],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Glycosyltransferase galactose \[c__\]],ParameterGroup=Parameters,Parameter=c__udpgal_tot" value="0.11" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__udpgal_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=galactose_28,Vector=Reactions[Glycosyltransferase galactose M \[c__\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Glycosyltransferase galactose M \[c__\]],ParameterGroup=Parameters,Parameter=c__GTFGAL_Vf" value="3.983854285714287e-18" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__GTFGAL_Vf],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Glycosyltransferase galactose M \[c__\]],ParameterGroup=Parameters,Parameter=c__udpgal_tot" value="0.11" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__udpgal_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=galactose_28,Vector=Reactions[Glycosyltransferase glucose \[c__\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Glycosyltransferase glucose \[c__\]],ParameterGroup=Parameters,Parameter=c__GTFGLC_Vf" value="0" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__GTFGLC_Vf],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Glycosyltransferase glucose \[c__\]],ParameterGroup=Parameters,Parameter=c__udpglc_tot" value="0.34" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__udpglc_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=galactose_28,Vector=Reactions[Glycosyltransferase glucose M \[c__\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Glycosyltransferase glucose M \[c__\]],ParameterGroup=Parameters,Parameter=c__GTFGLC_Vf" value="0" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__GTFGLC_Vf],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[Glycosyltransferase glucose M \[c__\]],ParameterGroup=Parameters,Parameter=c__udpglc_tot" value="0.34" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__udpglc_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=galactose_28,Vector=Reactions[H2O M transport \[e__\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[H2O M transport \[e__\]],ParameterGroup=Parameters,Parameter=H2OT_k" value="1" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[H2OT_k],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[H2O M transport \[e__\]],ParameterGroup=Parameters,Parameter=c__H2OT_Vmax" value="1.457e-14" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__H2OT_Vmax],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=galactose_28,Vector=Reactions[galactose transport \[e__\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[galactose transport \[e__\]],ParameterGroup=Parameters,Parameter=c__GLUT2_Vb" value="1.336445296875135e-19" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__GLUT2_Vb],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[galactose transport \[e__\]],ParameterGroup=Parameters,Parameter=c__GLUT2_Vf" value="1.336445296875134e-19" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__GLUT2_Vf],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[galactose transport \[e__\]],ParameterGroup=Parameters,Parameter=c__gal_tot" value="0.00012" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__gal_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[galactose transport \[e__\]],ParameterGroup=Parameters,Parameter=e__gal_tot" value="0.00012" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[e__gal_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
          <ModelParameterGroup cn="CN=Root,Model=galactose_28,Vector=Reactions[galactose transport M \[e__\]]" type="Reaction">
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[galactose transport M \[e__\]],ParameterGroup=Parameters,Parameter=c__GLUT2_Vb" value="1.336445296875135e-19" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__GLUT2_Vb],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[galactose transport M \[e__\]],ParameterGroup=Parameters,Parameter=c__GLUT2_Vf" value="1.336445296875134e-19" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__GLUT2_Vf],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[galactose transport M \[e__\]],ParameterGroup=Parameters,Parameter=c__gal_tot" value="0.00012" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[c__gal_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
            <ModelParameter cn="CN=Root,Model=galactose_28,Vector=Reactions[galactose transport M \[e__\]],ParameterGroup=Parameters,Parameter=e__gal_tot" value="0.00012" type="ReactionParameter" simulationType="assignment">
              <InitialExpression>
                &lt;CN=Root,Model=galactose_28,Vector=Values[e__gal_tot],Reference=InitialValue&gt;
              </InitialExpression>
            </ModelParameter>
          </ModelParameterGroup>
        </ModelParameterGroup>
      </ModelParameterSet>
    </ListOfModelParameterSets>
    <StateTemplate>
      <StateTemplateVariable objectReference="Model_5"/>
      <StateTemplateVariable objectReference="Metabolite_83"/>
      <StateTemplateVariable objectReference="Metabolite_23"/>
      <StateTemplateVariable objectReference="Metabolite_59"/>
      <StateTemplateVariable objectReference="Metabolite_25"/>
      <StateTemplateVariable objectReference="Metabolite_29"/>
      <StateTemplateVariable objectReference="Metabolite_35"/>
      <StateTemplateVariable objectReference="Metabolite_61"/>
      <StateTemplateVariable objectReference="Metabolite_17"/>
      <StateTemplateVariable objectReference="Metabolite_27"/>
      <StateTemplateVariable objectReference="Metabolite_69"/>
      <StateTemplateVariable objectReference="Metabolite_55"/>
      <StateTemplateVariable objectReference="Metabolite_33"/>
      <StateTemplateVariable objectReference="Metabolite_75"/>
      <StateTemplateVariable objectReference="Metabolite_67"/>
      <StateTemplateVariable objectReference="Metabolite_47"/>
      <StateTemplateVariable objectReference="Metabolite_71"/>
      <StateTemplateVariable objectReference="Metabolite_51"/>
      <StateTemplateVariable objectReference="Metabolite_43"/>
      <StateTemplateVariable objectReference="Metabolite_31"/>
      <StateTemplateVariable objectReference="Metabolite_41"/>
      <StateTemplateVariable objectReference="Metabolite_63"/>
      <StateTemplateVariable objectReference="Metabolite_65"/>
      <StateTemplateVariable objectReference="Metabolite_81"/>
      <StateTemplateVariable objectReference="Metabolite_13"/>
      <StateTemplateVariable objectReference="Metabolite_49"/>
      <StateTemplateVariable objectReference="Metabolite_15"/>
      <StateTemplateVariable objectReference="Compartment_7"/>
      <StateTemplateVariable objectReference="Compartment_9"/>
      <StateTemplateVariable objectReference="Compartment_11"/>
      <StateTemplateVariable objectReference="ModelValue_25"/>
      <StateTemplateVariable objectReference="ModelValue_26"/>
      <StateTemplateVariable objectReference="ModelValue_27"/>
      <StateTemplateVariable objectReference="ModelValue_30"/>
      <StateTemplateVariable objectReference="ModelValue_31"/>
      <StateTemplateVariable objectReference="ModelValue_32"/>
      <StateTemplateVariable objectReference="ModelValue_33"/>
      <StateTemplateVariable objectReference="ModelValue_34"/>
      <StateTemplateVariable objectReference="ModelValue_35"/>
      <StateTemplateVariable objectReference="ModelValue_47"/>
      <StateTemplateVariable objectReference="ModelValue_48"/>
      <StateTemplateVariable objectReference="ModelValue_49"/>
      <StateTemplateVariable objectReference="ModelValue_50"/>
      <StateTemplateVariable objectReference="ModelValue_51"/>
      <StateTemplateVariable objectReference="ModelValue_55"/>
      <StateTemplateVariable objectReference="ModelValue_56"/>
      <StateTemplateVariable objectReference="ModelValue_57"/>
      <StateTemplateVariable objectReference="ModelValue_64"/>
      <StateTemplateVariable objectReference="ModelValue_72"/>
      <StateTemplateVariable objectReference="ModelValue_73"/>
      <StateTemplateVariable objectReference="ModelValue_74"/>
      <StateTemplateVariable objectReference="ModelValue_75"/>
      <StateTemplateVariable objectReference="ModelValue_76"/>
      <StateTemplateVariable objectReference="ModelValue_82"/>
      <StateTemplateVariable objectReference="ModelValue_93"/>
      <StateTemplateVariable objectReference="ModelValue_94"/>
      <StateTemplateVariable objectReference="ModelValue_95"/>
      <StateTemplateVariable objectReference="ModelValue_96"/>
      <StateTemplateVariable objectReference="ModelValue_97"/>
      <StateTemplateVariable objectReference="ModelValue_105"/>
      <StateTemplateVariable objectReference="ModelValue_106"/>
      <StateTemplateVariable objectReference="ModelValue_107"/>
      <StateTemplateVariable objectReference="ModelValue_108"/>
      <StateTemplateVariable objectReference="ModelValue_109"/>
      <StateTemplateVariable objectReference="ModelValue_121"/>
      <StateTemplateVariable objectReference="ModelValue_122"/>
      <StateTemplateVariable objectReference="ModelValue_123"/>
      <StateTemplateVariable objectReference="ModelValue_124"/>
      <StateTemplateVariable objectReference="ModelValue_125"/>
      <StateTemplateVariable objectReference="ModelValue_127"/>
      <StateTemplateVariable objectReference="ModelValue_128"/>
      <StateTemplateVariable objectReference="ModelValue_129"/>
      <StateTemplateVariable objectReference="ModelValue_134"/>
      <StateTemplateVariable objectReference="ModelValue_142"/>
      <StateTemplateVariable objectReference="ModelValue_148"/>
      <StateTemplateVariable objectReference="ModelValue_149"/>
      <StateTemplateVariable objectReference="ModelValue_150"/>
      <StateTemplateVariable objectReference="ModelValue_151"/>
      <StateTemplateVariable objectReference="ModelValue_152"/>
      <StateTemplateVariable objectReference="ModelValue_157"/>
      <StateTemplateVariable objectReference="ModelValue_162"/>
      <StateTemplateVariable objectReference="ModelValue_163"/>
      <StateTemplateVariable objectReference="ModelValue_164"/>
      <StateTemplateVariable objectReference="ModelValue_167"/>
      <StateTemplateVariable objectReference="ModelValue_171"/>
      <StateTemplateVariable objectReference="ModelValue_172"/>
      <StateTemplateVariable objectReference="ModelValue_173"/>
      <StateTemplateVariable objectReference="ModelValue_174"/>
      <StateTemplateVariable objectReference="ModelValue_175"/>
      <StateTemplateVariable objectReference="Compartment_13"/>
      <StateTemplateVariable objectReference="ModelValue_28"/>
      <StateTemplateVariable objectReference="ModelValue_29"/>
      <StateTemplateVariable objectReference="ModelValue_36"/>
      <StateTemplateVariable objectReference="ModelValue_37"/>
      <StateTemplateVariable objectReference="Metabolite_19"/>
      <StateTemplateVariable objectReference="Metabolite_21"/>
      <StateTemplateVariable objectReference="Metabolite_37"/>
      <StateTemplateVariable objectReference="Metabolite_39"/>
      <StateTemplateVariable objectReference="Metabolite_45"/>
      <StateTemplateVariable objectReference="Metabolite_53"/>
      <StateTemplateVariable objectReference="Metabolite_57"/>
      <StateTemplateVariable objectReference="Metabolite_73"/>
      <StateTemplateVariable objectReference="Metabolite_77"/>
      <StateTemplateVariable objectReference="Metabolite_79"/>
      <StateTemplateVariable objectReference="ModelValue_13"/>
      <StateTemplateVariable objectReference="ModelValue_14"/>
      <StateTemplateVariable objectReference="ModelValue_15"/>
      <StateTemplateVariable objectReference="ModelValue_16"/>
      <StateTemplateVariable objectReference="ModelValue_17"/>
      <StateTemplateVariable objectReference="ModelValue_18"/>
      <StateTemplateVariable objectReference="ModelValue_19"/>
      <StateTemplateVariable objectReference="ModelValue_20"/>
      <StateTemplateVariable objectReference="ModelValue_21"/>
      <StateTemplateVariable objectReference="ModelValue_22"/>
      <StateTemplateVariable objectReference="ModelValue_23"/>
      <StateTemplateVariable objectReference="ModelValue_24"/>
      <StateTemplateVariable objectReference="ModelValue_38"/>
      <StateTemplateVariable objectReference="ModelValue_39"/>
      <StateTemplateVariable objectReference="ModelValue_40"/>
      <StateTemplateVariable objectReference="ModelValue_41"/>
      <StateTemplateVariable objectReference="ModelValue_42"/>
      <StateTemplateVariable objectReference="ModelValue_43"/>
      <StateTemplateVariable objectReference="ModelValue_44"/>
      <StateTemplateVariable objectReference="ModelValue_45"/>
      <StateTemplateVariable objectReference="ModelValue_46"/>
      <StateTemplateVariable objectReference="ModelValue_52"/>
      <StateTemplateVariable objectReference="ModelValue_53"/>
      <StateTemplateVariable objectReference="ModelValue_54"/>
      <StateTemplateVariable objectReference="ModelValue_58"/>
      <StateTemplateVariable objectReference="ModelValue_59"/>
      <StateTemplateVariable objectReference="ModelValue_60"/>
      <StateTemplateVariable objectReference="ModelValue_61"/>
      <StateTemplateVariable objectReference="ModelValue_62"/>
      <StateTemplateVariable objectReference="ModelValue_63"/>
      <StateTemplateVariable objectReference="ModelValue_65"/>
      <StateTemplateVariable objectReference="ModelValue_66"/>
      <StateTemplateVariable objectReference="ModelValue_67"/>
      <StateTemplateVariable objectReference="ModelValue_68"/>
      <StateTemplateVariable objectReference="ModelValue_69"/>
      <StateTemplateVariable objectReference="ModelValue_70"/>
      <StateTemplateVariable objectReference="ModelValue_71"/>
      <StateTemplateVariable objectReference="ModelValue_77"/>
      <StateTemplateVariable objectReference="ModelValue_78"/>
      <StateTemplateVariable objectReference="ModelValue_79"/>
      <StateTemplateVariable objectReference="ModelValue_80"/>
      <StateTemplateVariable objectReference="ModelValue_81"/>
      <StateTemplateVariable objectReference="ModelValue_83"/>
      <StateTemplateVariable objectReference="ModelValue_84"/>
      <StateTemplateVariable objectReference="ModelValue_85"/>
      <StateTemplateVariable objectReference="ModelValue_86"/>
      <StateTemplateVariable objectReference="ModelValue_87"/>
      <StateTemplateVariable objectReference="ModelValue_88"/>
      <StateTemplateVariable objectReference="ModelValue_89"/>
      <StateTemplateVariable objectReference="ModelValue_90"/>
      <StateTemplateVariable objectReference="ModelValue_91"/>
      <StateTemplateVariable objectReference="ModelValue_92"/>
      <StateTemplateVariable objectReference="ModelValue_98"/>
      <StateTemplateVariable objectReference="ModelValue_99"/>
      <StateTemplateVariable objectReference="ModelValue_100"/>
      <StateTemplateVariable objectReference="ModelValue_101"/>
      <StateTemplateVariable objectReference="ModelValue_102"/>
      <StateTemplateVariable objectReference="ModelValue_103"/>
      <StateTemplateVariable objectReference="ModelValue_104"/>
      <StateTemplateVariable objectReference="ModelValue_110"/>
      <StateTemplateVariable objectReference="ModelValue_111"/>
      <StateTemplateVariable objectReference="ModelValue_112"/>
      <StateTemplateVariable objectReference="ModelValue_113"/>
      <StateTemplateVariable objectReference="ModelValue_114"/>
      <StateTemplateVariable objectReference="ModelValue_115"/>
      <StateTemplateVariable objectReference="ModelValue_116"/>
      <StateTemplateVariable objectReference="ModelValue_117"/>
      <StateTemplateVariable objectReference="ModelValue_118"/>
      <StateTemplateVariable objectReference="ModelValue_119"/>
      <StateTemplateVariable objectReference="ModelValue_120"/>
      <StateTemplateVariable objectReference="ModelValue_126"/>
      <StateTemplateVariable objectReference="ModelValue_130"/>
      <StateTemplateVariable objectReference="ModelValue_131"/>
      <StateTemplateVariable objectReference="ModelValue_132"/>
      <StateTemplateVariable objectReference="ModelValue_133"/>
      <StateTemplateVariable objectReference="ModelValue_135"/>
      <StateTemplateVariable objectReference="ModelValue_136"/>
      <StateTemplateVariable objectReference="ModelValue_137"/>
      <StateTemplateVariable objectReference="ModelValue_138"/>
      <StateTemplateVariable objectReference="ModelValue_139"/>
      <StateTemplateVariable objectReference="ModelValue_140"/>
      <StateTemplateVariable objectReference="ModelValue_141"/>
      <StateTemplateVariable objectReference="ModelValue_143"/>
      <StateTemplateVariable objectReference="ModelValue_144"/>
      <StateTemplateVariable objectReference="ModelValue_145"/>
      <StateTemplateVariable objectReference="ModelValue_146"/>
      <StateTemplateVariable objectReference="ModelValue_147"/>
      <StateTemplateVariable objectReference="ModelValue_153"/>
      <StateTemplateVariable objectReference="ModelValue_154"/>
      <StateTemplateVariable objectReference="ModelValue_155"/>
      <StateTemplateVariable objectReference="ModelValue_156"/>
      <StateTemplateVariable objectReference="ModelValue_158"/>
      <StateTemplateVariable objectReference="ModelValue_159"/>
      <StateTemplateVariable objectReference="ModelValue_160"/>
      <StateTemplateVariable objectReference="ModelValue_161"/>
      <StateTemplateVariable objectReference="ModelValue_165"/>
      <StateTemplateVariable objectReference="ModelValue_166"/>
      <StateTemplateVariable objectReference="ModelValue_168"/>
      <StateTemplateVariable objectReference="ModelValue_169"/>
      <StateTemplateVariable objectReference="ModelValue_170"/>
    </StateTemplate>
    <InitialState type="initialState">
      0 7076016603.250001 155672365.2715 0 127368298.8585 382104896.5755001 169824.398478 0 16982439.84780001 3821048965.755001 0 141520332.065 0 1415203.32065 0 169824398.478 481169129.0210001 0 0 424560.996195 0 1415203.32065 141520332.065 0 11321626.5652 1698243984.78 0 5.875e-15 2.35e-15 5.875e-15 0.00012 0.00012 0.34 0.12 0.0009999999999999998 1.82125e-15 0.0009999999999999998 0.012 0.11 9.742956830412509e-16 2.338309639299002e-20 3.80277e-16 81.98235574229692 3.156718013053654e-19 1.002857142857143 5.417051282051282e-20 1.901385e-17 3.80277e-14 7.922289617260477e-16 3.168915846904192e-11 3.80277e-10 3.000056 3.802699016285031e-16 3.80277e-20 4.407846492208454e-19 1.296425438884839e-15 3.05742708e-15 1.711281579327988e-18 4.387630986938894 8.763095132396961e-17 2.628928539719088e-16 1.1417436648e-16 6.294202898550724 8.938357035044901e-17 2.498511886502129e-15 7.711456439821385e-13 7.605540000000001e-13 10.18490079862424 4.66114700362537e-15 5.187582429917176e-19 2.652741015298557e-16 7.162400741306102e-20 3.802770000000001e-14 1.521108e-12 3.507028079834825e-15 2.922523399862354e-13 1.901385e-14 1.445771144278607 3.507028079834825e-15 1.901385e-15 3.983854285714287e-18 7.605540000000001e-18 0 1.457e-14 1.000008633093525 1.336445296875135e-19 1.113704414062612e-15 1.336445296875134e-19 3.096125e-14 6.25e-10 3.9 17.539 0.8099999999999999 0.2 0 0 0 0 0 0 0 0 0 0 0.31 9.4e-06 2.5e-05 0.4 1 0 1 0.8 5.875e-15 2.35e-15 6.25e-10 5.875e-15 0.024 50 1.5 0.8 5.3 8.699999999999999 0.14 0.034 1 0.05 0.35 1 100 0.58 0.1 0.5 0.1 1 1000000 4 40 40 0.1 0.1 1 1e-10 1 0.015 0.01 1 0.01 1 0.37 0.5 0.13 0.35 804 1.25 0.43 1 0.3 0.0278 36 0.33 0.06900000000000001 0.3 1 2000 0.45 0.5629999999999999 0.172 0.049 0.166 5 0.42 0.643 0.643 1 0.01 0.05 0.07000000000000001 4 1 2 1 1.33 0.042 27 0.19 1 50 10 0.67 0.045 1 0.1 0.12 0.2 1 0.02 0.1 0.1 1 8 1 17 27.8 1 
    </InitialState>
  </Model>
  <ListOfTasks>
    <Task key="Task_26" name="Steady-State" type="steadyState" scheduled="false" updateModel="false">
      <Report reference="Report_17" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="JacobianRequested" type="bool" value="1"/>
        <Parameter name="StabilityAnalysisRequested" type="bool" value="1"/>
      </Problem>
      <Method name="Enhanced Newton" type="EnhancedNewton">
        <Parameter name="Resolution" type="unsignedFloat" value="1e-09"/>
        <Parameter name="Derivation Factor" type="unsignedFloat" value="0.001"/>
        <Parameter name="Use Newton" type="bool" value="1"/>
        <Parameter name="Use Integration" type="bool" value="1"/>
        <Parameter name="Use Back Integration" type="bool" value="1"/>
        <Parameter name="Accept Negative Concentrations" type="bool" value="0"/>
        <Parameter name="Iteration Limit" type="unsignedInteger" value="50"/>
        <Parameter name="Maximum duration for forward integration" type="unsignedFloat" value="1000000000"/>
        <Parameter name="Maximum duration for backward integration" type="unsignedFloat" value="1000000"/>
      </Method>
    </Task>
    <Task key="Task_25" name="Time-Course" type="timeCourse" scheduled="false" updateModel="false">
      <Problem>
        <Parameter name="StepNumber" type="unsignedInteger" value="10000"/>
        <Parameter name="StepSize" type="float" value="0.1"/>
        <Parameter name="Duration" type="float" value="1000"/>
        <Parameter name="TimeSeriesRequested" type="bool" value="1"/>
        <Parameter name="OutputStartTime" type="float" value="0"/>
        <Parameter name="Output Event" type="bool" value="0"/>
        <Parameter name="Continue on Simultaneous Events" type="bool" value="1"/>
      </Problem>
      <Method name="Deterministic (LSODA)" type="Deterministic(LSODA)">
        <Parameter name="Integrate Reduced Model" type="bool" value="0"/>
        <Parameter name="Relative Tolerance" type="unsignedFloat" value="1e-06"/>
        <Parameter name="Absolute Tolerance" type="unsignedFloat" value="1e-12"/>
        <Parameter name="Max Internal Steps" type="unsignedInteger" value="10000"/>
      </Method>
    </Task>
    <Task key="Task_24" name="Scan" type="scan" scheduled="false" updateModel="false">
      <Problem>
        <Parameter name="Subtask" type="unsignedInteger" value="1"/>
        <ParameterGroup name="ScanItems">
          <ParameterGroup name="ScanItem">
            <Parameter name="Number of steps" type="unsignedInteger" value="10"/>
            <Parameter name="Type" type="unsignedInteger" value="1"/>
            <Parameter name="Object" type="cn" value="CN=Root,Model=galactose_28,Vector=Compartments[external],Vector=Metabolites[D-galactose],Reference=InitialConcentration"/>
            <Parameter name="Minimum" type="float" value="1e-08"/>
            <Parameter name="Maximum" type="float" value="10"/>
            <Parameter name="log" type="bool" value="0"/>
          </ParameterGroup>
        </ParameterGroup>
        <Parameter name="Output in subtask" type="bool" value="1"/>
        <Parameter name="Adjust initial conditions" type="bool" value="0"/>
      </Problem>
      <Method name="Scan Framework" type="ScanFramework">
      </Method>
    </Task>
    <Task key="Task_23" name="Elementary Flux Modes" type="fluxMode" scheduled="false" updateModel="false">
      <Report reference="Report_16" target="" append="1" confirmOverwrite="1"/>
      <Problem>
      </Problem>
      <Method name="EFM Algorithm" type="EFMAlgorithm">
      </Method>
    </Task>
    <Task key="Task_22" name="Optimization" type="optimization" scheduled="false" updateModel="false">
      <Report reference="Report_15" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="Subtask" type="cn" value="CN=Root,Vector=TaskList[Steady-State]"/>
        <ParameterText name="ObjectiveExpression" type="expression">
          
        </ParameterText>
        <Parameter name="Maximize" type="bool" value="0"/>
        <Parameter name="Randomize Start Values" type="bool" value="0"/>
        <Parameter name="Calculate Statistics" type="bool" value="1"/>
        <ParameterGroup name="OptimizationItemList">
        </ParameterGroup>
        <ParameterGroup name="OptimizationConstraintList">
        </ParameterGroup>
      </Problem>
      <Method name="Random Search" type="RandomSearch">
        <Parameter name="Number of Iterations" type="unsignedInteger" value="100000"/>
        <Parameter name="Random Number Generator" type="unsignedInteger" value="1"/>
        <Parameter name="Seed" type="unsignedInteger" value="0"/>
      </Method>
    </Task>
    <Task key="Task_21" name="Parameter Estimation" type="parameterFitting" scheduled="false" updateModel="false">
      <Report reference="Report_14" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="Maximize" type="bool" value="0"/>
        <Parameter name="Randomize Start Values" type="bool" value="0"/>
        <Parameter name="Calculate Statistics" type="bool" value="1"/>
        <ParameterGroup name="OptimizationItemList">
        </ParameterGroup>
        <ParameterGroup name="OptimizationConstraintList">
        </ParameterGroup>
        <Parameter name="Steady-State" type="cn" value="CN=Root,Vector=TaskList[Steady-State]"/>
        <Parameter name="Time-Course" type="cn" value="CN=Root,Vector=TaskList[Time-Course]"/>
        <Parameter name="Create Parameter Sets" type="bool" value="0"/>
        <ParameterGroup name="Experiment Set">
        </ParameterGroup>
        <ParameterGroup name="Validation Set">
          <Parameter name="Weight" type="unsignedFloat" value="1"/>
          <Parameter name="Threshold" type="unsignedInteger" value="5"/>
        </ParameterGroup>
      </Problem>
      <Method name="Evolutionary Programming" type="EvolutionaryProgram">
        <Parameter name="Number of Generations" type="unsignedInteger" value="200"/>
        <Parameter name="Population Size" type="unsignedInteger" value="20"/>
        <Parameter name="Random Number Generator" type="unsignedInteger" value="1"/>
        <Parameter name="Seed" type="unsignedInteger" value="0"/>
      </Method>
    </Task>
    <Task key="Task_20" name="Metabolic Control Analysis" type="metabolicControlAnalysis" scheduled="false" updateModel="false">
      <Report reference="Report_13" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="Steady-State" type="key" value="Task_26"/>
      </Problem>
      <Method name="MCA Method (Reder)" type="MCAMethod(Reder)">
        <Parameter name="Modulation Factor" type="unsignedFloat" value="1e-09"/>
        <Parameter name="Use Reeder" type="bool" value="1"/>
        <Parameter name="Use Smallbone" type="bool" value="1"/>
      </Method>
    </Task>
    <Task key="Task_19" name="Lyapunov Exponents" type="lyapunovExponents" scheduled="false" updateModel="false">
      <Report reference="Report_12" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="ExponentNumber" type="unsignedInteger" value="3"/>
        <Parameter name="DivergenceRequested" type="bool" value="1"/>
        <Parameter name="TransientTime" type="float" value="0"/>
      </Problem>
      <Method name="Wolf Method" type="WolfMethod">
        <Parameter name="Orthonormalization Interval" type="unsignedFloat" value="1"/>
        <Parameter name="Overall time" type="unsignedFloat" value="1000"/>
        <Parameter name="Relative Tolerance" type="unsignedFloat" value="1e-06"/>
        <Parameter name="Absolute Tolerance" type="unsignedFloat" value="1e-12"/>
        <Parameter name="Max Internal Steps" type="unsignedInteger" value="10000"/>
      </Method>
    </Task>
    <Task key="Task_18" name="Time Scale Separation Analysis" type="timeScaleSeparationAnalysis" scheduled="false" updateModel="false">
      <Report reference="Report_11" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="StepNumber" type="unsignedInteger" value="100"/>
        <Parameter name="StepSize" type="float" value="0.01"/>
        <Parameter name="Duration" type="float" value="1"/>
        <Parameter name="TimeSeriesRequested" type="bool" value="1"/>
        <Parameter name="OutputStartTime" type="float" value="0"/>
      </Problem>
      <Method name="ILDM (LSODA,Deuflhard)" type="TimeScaleSeparation(ILDM,Deuflhard)">
        <Parameter name="Deuflhard Tolerance" type="unsignedFloat" value="1e-06"/>
      </Method>
    </Task>
    <Task key="Task_17" name="Sensitivities" type="sensitivities" scheduled="false" updateModel="false">
      <Report reference="Report_10" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="SubtaskType" type="unsignedInteger" value="1"/>
        <ParameterGroup name="TargetFunctions">
          <Parameter name="SingleObject" type="cn" value=""/>
          <Parameter name="ObjectListType" type="unsignedInteger" value="7"/>
        </ParameterGroup>
        <ParameterGroup name="ListOfVariables">
          <ParameterGroup name="Variables">
            <Parameter name="SingleObject" type="cn" value=""/>
            <Parameter name="ObjectListType" type="unsignedInteger" value="41"/>
          </ParameterGroup>
        </ParameterGroup>
      </Problem>
      <Method name="Sensitivities Method" type="SensitivitiesMethod">
        <Parameter name="Delta factor" type="unsignedFloat" value="0.001"/>
        <Parameter name="Delta minimum" type="unsignedFloat" value="1e-12"/>
      </Method>
    </Task>
    <Task key="Task_16" name="Moieties" type="moieties" scheduled="false" updateModel="false">
      <Problem>
      </Problem>
      <Method name="Householder Reduction" type="Householder">
      </Method>
    </Task>
    <Task key="Task_15" name="Cross Section" type="crosssection" scheduled="false" updateModel="false">
      <Problem>
        <Parameter name="StepNumber" type="unsignedInteger" value="100"/>
        <Parameter name="StepSize" type="float" value="0.01"/>
        <Parameter name="Duration" type="float" value="1"/>
        <Parameter name="TimeSeriesRequested" type="bool" value="1"/>
        <Parameter name="OutputStartTime" type="float" value="0"/>
        <Parameter name="Output Event" type="bool" value="0"/>
        <Parameter name="Continue on Simultaneous Events" type="bool" value="0"/>
        <Parameter name="LimitCrossings" type="bool" value="0"/>
        <Parameter name="NumCrossingsLimit" type="unsignedInteger" value="0"/>
        <Parameter name="LimitOutTime" type="bool" value="0"/>
        <Parameter name="LimitOutCrossings" type="bool" value="0"/>
        <Parameter name="PositiveDirection" type="bool" value="1"/>
        <Parameter name="NumOutCrossingsLimit" type="unsignedInteger" value="0"/>
        <Parameter name="LimitUntilConvergence" type="bool" value="0"/>
        <Parameter name="ConvergenceTolerance" type="float" value="1e-06"/>
        <Parameter name="Threshold" type="float" value="0"/>
        <Parameter name="DelayOutputUntilConvergence" type="bool" value="0"/>
        <Parameter name="OutputConvergenceTolerance" type="float" value="1e-06"/>
        <ParameterText name="TriggerExpression" type="expression">
          
        </ParameterText>
        <Parameter name="SingleVariable" type="cn" value=""/>
      </Problem>
      <Method name="Deterministic (LSODA)" type="Deterministic(LSODA)">
        <Parameter name="Integrate Reduced Model" type="bool" value="0"/>
        <Parameter name="Relative Tolerance" type="unsignedFloat" value="1e-06"/>
        <Parameter name="Absolute Tolerance" type="unsignedFloat" value="1e-12"/>
        <Parameter name="Max Internal Steps" type="unsignedInteger" value="10000"/>
      </Method>
    </Task>
    <Task key="Task_27" name="Linear Noise Approximation" type="linearNoiseApproximation" scheduled="false" updateModel="false">
      <Report reference="Report_9" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="Steady-State" type="key" value="Task_26"/>
      </Problem>
      <Method name="Linear Noise Approximation" type="LinearNoiseApproximation">
      </Method>
    </Task>
  </ListOfTasks>
  <ListOfReports>
    <Report key="Report_17" name="Steady-State" taskType="steadyState" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Footer>
        <Object cn="CN=Root,Vector=TaskList[Steady-State]"/>
      </Footer>
    </Report>
    <Report key="Report_16" name="Elementary Flux Modes" taskType="fluxMode" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Footer>
        <Object cn="CN=Root,Vector=TaskList[Elementary Flux Modes],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_15" name="Optimization" taskType="optimization" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Header>
        <Object cn="CN=Root,Vector=TaskList[Optimization],Object=Description"/>
        <Object cn="String=\[Function Evaluations\]"/>
        <Object cn="Separator=&#x09;"/>
        <Object cn="String=\[Best Value\]"/>
        <Object cn="Separator=&#x09;"/>
        <Object cn="String=\[Best Parameters\]"/>
      </Header>
      <Body>
        <Object cn="CN=Root,Vector=TaskList[Optimization],Problem=Optimization,Reference=Function Evaluations"/>
        <Object cn="Separator=&#x09;"/>
        <Object cn="CN=Root,Vector=TaskList[Optimization],Problem=Optimization,Reference=Best Value"/>
        <Object cn="Separator=&#x09;"/>
        <Object cn="CN=Root,Vector=TaskList[Optimization],Problem=Optimization,Reference=Best Parameters"/>
      </Body>
      <Footer>
        <Object cn="String=&#x0a;"/>
        <Object cn="CN=Root,Vector=TaskList[Optimization],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_14" name="Parameter Estimation" taskType="parameterFitting" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Header>
        <Object cn="CN=Root,Vector=TaskList[Parameter Estimation],Object=Description"/>
        <Object cn="String=\[Function Evaluations\]"/>
        <Object cn="Separator=&#x09;"/>
        <Object cn="String=\[Best Value\]"/>
        <Object cn="Separator=&#x09;"/>
        <Object cn="String=\[Best Parameters\]"/>
      </Header>
      <Body>
        <Object cn="CN=Root,Vector=TaskList[Parameter Estimation],Problem=Parameter Estimation,Reference=Function Evaluations"/>
        <Object cn="Separator=&#x09;"/>
        <Object cn="CN=Root,Vector=TaskList[Parameter Estimation],Problem=Parameter Estimation,Reference=Best Value"/>
        <Object cn="Separator=&#x09;"/>
        <Object cn="CN=Root,Vector=TaskList[Parameter Estimation],Problem=Parameter Estimation,Reference=Best Parameters"/>
      </Body>
      <Footer>
        <Object cn="String=&#x0a;"/>
        <Object cn="CN=Root,Vector=TaskList[Parameter Estimation],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_13" name="Metabolic Control Analysis" taskType="metabolicControlAnalysis" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Header>
        <Object cn="CN=Root,Vector=TaskList[Metabolic Control Analysis],Object=Description"/>
      </Header>
      <Footer>
        <Object cn="String=&#x0a;"/>
        <Object cn="CN=Root,Vector=TaskList[Metabolic Control Analysis],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_12" name="Lyapunov Exponents" taskType="lyapunovExponents" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Header>
        <Object cn="CN=Root,Vector=TaskList[Lyapunov Exponents],Object=Description"/>
      </Header>
      <Footer>
        <Object cn="String=&#x0a;"/>
        <Object cn="CN=Root,Vector=TaskList[Lyapunov Exponents],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_11" name="Time Scale Separation Analysis" taskType="timeScaleSeparationAnalysis" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Header>
        <Object cn="CN=Root,Vector=TaskList[Time Scale Separation Analysis],Object=Description"/>
      </Header>
      <Footer>
        <Object cn="String=&#x0a;"/>
        <Object cn="CN=Root,Vector=TaskList[Time Scale Separation Analysis],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_10" name="Sensitivities" taskType="sensitivities" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Header>
        <Object cn="CN=Root,Vector=TaskList[Sensitivities],Object=Description"/>
      </Header>
      <Footer>
        <Object cn="String=&#x0a;"/>
        <Object cn="CN=Root,Vector=TaskList[Sensitivities],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_9" name="Linear Noise Approximation" taskType="linearNoiseApproximation" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Header>
        <Object cn="CN=Root,Vector=TaskList[Linear Noise Approximation],Object=Description"/>
      </Header>
      <Footer>
        <Object cn="String=&#x0a;"/>
        <Object cn="CN=Root,Vector=TaskList[Linear Noise Approximation],Object=Result"/>
      </Footer>
    </Report>
  </ListOfReports>
  <ListOfPlots>
    <PlotSpecification name="plot_1" type="Plot2D" active="1">
      <Parameter name="log X" type="bool" value="0"/>
      <Parameter name="log Y" type="bool" value="0"/>
      <ListOfPlotItems>
        <PlotItem name="[ADP]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[ADP],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[ATP]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[ATP],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Acceptor (glc/gal)]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[Acceptor (glc/gal)],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Acceptor-galactose M*]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[Acceptor-galactose M*],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Acceptor-galactose]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[Acceptor-galactose],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Acceptor-glucose M*]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[Acceptor-glucose M*],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Acceptor-glucose]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[Acceptor-glucose],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[CO2]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[CO2],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[D-galactitol M*]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[D-galactitol M*],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[D-galactitol]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[D-galactitol],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[D-galactose 1-phosphate M*]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[D-galactose 1-phosphate M*],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[D-galactose 1-phosphate]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[D-galactose 1-phosphate],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[D-galactose M*{cytosol}]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[D-galactose M*],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[D-galactose M*{external}]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Vector=Compartments[external],Vector=Metabolites[D-galactose M*],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[D-galactose{cytosol}]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[D-galactose],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[D-galactose{external}]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Vector=Compartments[external],Vector=Metabolites[D-galactose],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[D-glucose 1-phophate M*]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[D-glucose 1-phophate M*],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[D-glucose 1-phophate]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[D-glucose 1-phophate],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[D-glucose 6-phosphate M*]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[D-glucose 6-phosphate M*],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[D-glucose 6-phosphate]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[D-glucose 6-phosphate],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[H+]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[H+],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[H2]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[H2],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[NADPH]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[NADPH],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[NADP]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[NADP],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[O2]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[O2],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[UDP-D-galactose M*]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[UDP-D-galactose M*],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[UDP-D-galactose]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[UDP-D-galactose],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[UDP-D-glucose M*]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[UDP-D-glucose M*],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[UDP-D-glucose]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[UDP-D-glucose],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[UDP]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[UDP],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[UTP]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[UTP],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[phosphate]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[phosphate],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[pyrophosphate]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[pyrophosphate],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[water M*{external}]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Vector=Compartments[external],Vector=Metabolites[water M*],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[water M*{hepatocyte}]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Vector=Compartments[hepatocyte],Vector=Metabolites[water M*],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[water]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[water],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
      </ListOfPlotItems>
    </PlotSpecification>
    <PlotSpecification name="plot_2" type="Plot2D" active="1">
      <Parameter name="log X" type="bool" value="0"/>
      <Parameter name="log Y" type="bool" value="0"/>
      <ListOfPlotItems>
        <PlotItem name="[D-galactose{cytosol}]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=galactose_28,Vector=Compartments[cytosol],Vector=Metabolites[D-galactose],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
      </ListOfPlotItems>
    </PlotSpecification>
  </ListOfPlots>
  <GUI>
  </GUI>
  <SBMLReference file="galactose_28_annotated.xml">
    <SBMLMap SBMLid="ALDR_f" COPASIkey="ModelValue_65"/>
    <SBMLMap SBMLid="ALDR_k_gal" COPASIkey="ModelValue_67"/>
    <SBMLMap SBMLid="ALDR_k_galtol" COPASIkey="ModelValue_68"/>
    <SBMLMap SBMLid="ALDR_k_nadp" COPASIkey="ModelValue_69"/>
    <SBMLMap SBMLid="ALDR_k_nadph" COPASIkey="ModelValue_70"/>
    <SBMLMap SBMLid="ALDR_keq" COPASIkey="ModelValue_66"/>
    <SBMLMap SBMLid="ATPS_f" COPASIkey="ModelValue_58"/>
    <SBMLMap SBMLid="ATPS_k_adp" COPASIkey="ModelValue_60"/>
    <SBMLMap SBMLid="ATPS_k_atp" COPASIkey="ModelValue_61"/>
    <SBMLMap SBMLid="ATPS_k_phos" COPASIkey="ModelValue_62"/>
    <SBMLMap SBMLid="ATPS_keq" COPASIkey="ModelValue_59"/>
    <SBMLMap SBMLid="A_m" COPASIkey="ModelValue_23"/>
    <SBMLMap SBMLid="GALE_PA" COPASIkey="ModelValue_99"/>
    <SBMLMap SBMLid="GALE_f" COPASIkey="ModelValue_98"/>
    <SBMLMap SBMLid="GALE_k_udpgal" COPASIkey="ModelValue_103"/>
    <SBMLMap SBMLid="GALE_k_udpglc" COPASIkey="ModelValue_102"/>
    <SBMLMap SBMLid="GALE_kcat" COPASIkey="ModelValue_100"/>
    <SBMLMap SBMLid="GALE_keq" COPASIkey="ModelValue_101"/>
    <SBMLMap SBMLid="GALK_PA" COPASIkey="ModelValue_38"/>
    <SBMLMap SBMLid="GALK_k_adp" COPASIkey="ModelValue_41"/>
    <SBMLMap SBMLid="GALK_k_atp" COPASIkey="ModelValue_45"/>
    <SBMLMap SBMLid="GALK_k_gal" COPASIkey="ModelValue_44"/>
    <SBMLMap SBMLid="GALK_k_gal1p" COPASIkey="ModelValue_40"/>
    <SBMLMap SBMLid="GALK_kcat" COPASIkey="ModelValue_43"/>
    <SBMLMap SBMLid="GALK_keq" COPASIkey="ModelValue_39"/>
    <SBMLMap SBMLid="GALK_ki_gal1p" COPASIkey="ModelValue_42"/>
    <SBMLMap SBMLid="GALT_f" COPASIkey="ModelValue_83"/>
    <SBMLMap SBMLid="GALT_k_gal1p" COPASIkey="ModelValue_90"/>
    <SBMLMap SBMLid="GALT_k_glc1p" COPASIkey="ModelValue_85"/>
    <SBMLMap SBMLid="GALT_k_udpgal" COPASIkey="ModelValue_86"/>
    <SBMLMap SBMLid="GALT_k_udpglc" COPASIkey="ModelValue_91"/>
    <SBMLMap SBMLid="GALT_keq" COPASIkey="ModelValue_84"/>
    <SBMLMap SBMLid="GALT_ki_udp" COPASIkey="ModelValue_88"/>
    <SBMLMap SBMLid="GALT_ki_utp" COPASIkey="ModelValue_87"/>
    <SBMLMap SBMLid="GALT_vm" COPASIkey="ModelValue_89"/>
    <SBMLMap SBMLid="GLUT2_f" COPASIkey="ModelValue_168"/>
    <SBMLMap SBMLid="GLUT2_k_gal" COPASIkey="ModelValue_169"/>
    <SBMLMap SBMLid="GLY_f" COPASIkey="ModelValue_153"/>
    <SBMLMap SBMLid="GLY_k_glc6p" COPASIkey="ModelValue_154"/>
    <SBMLMap SBMLid="GLY_k_p" COPASIkey="ModelValue_155"/>
    <SBMLMap SBMLid="GTF_f" COPASIkey="ModelValue_158"/>
    <SBMLMap SBMLid="GTF_k_udpgal" COPASIkey="ModelValue_159"/>
    <SBMLMap SBMLid="GTF_k_udpglc" COPASIkey="ModelValue_160"/>
    <SBMLMap SBMLid="H2OT_f" COPASIkey="ModelValue_165"/>
    <SBMLMap SBMLid="H2OT_k" COPASIkey="ModelValue_166"/>
    <SBMLMap SBMLid="IMP_f" COPASIkey="ModelValue_52"/>
    <SBMLMap SBMLid="IMP_k_gal1p" COPASIkey="ModelValue_53"/>
    <SBMLMap SBMLid="NADPR_f" COPASIkey="ModelValue_77"/>
    <SBMLMap SBMLid="NADPR_k_nadp" COPASIkey="ModelValue_79"/>
    <SBMLMap SBMLid="NADPR_keq" COPASIkey="ModelValue_78"/>
    <SBMLMap SBMLid="NADPR_ki_nadph" COPASIkey="ModelValue_80"/>
    <SBMLMap SBMLid="NDKU_f" COPASIkey="ModelValue_135"/>
    <SBMLMap SBMLid="NDKU_k_adp" COPASIkey="ModelValue_138"/>
    <SBMLMap SBMLid="NDKU_k_atp" COPASIkey="ModelValue_137"/>
    <SBMLMap SBMLid="NDKU_k_udp" COPASIkey="ModelValue_140"/>
    <SBMLMap SBMLid="NDKU_k_utp" COPASIkey="ModelValue_139"/>
    <SBMLMap SBMLid="NDKU_keq" COPASIkey="ModelValue_136"/>
    <SBMLMap SBMLid="Nf" COPASIkey="ModelValue_17"/>
    <SBMLMap SBMLid="PGM1_f" COPASIkey="ModelValue_143"/>
    <SBMLMap SBMLid="PGM1_k_glc1p" COPASIkey="ModelValue_146"/>
    <SBMLMap SBMLid="PGM1_k_glc6p" COPASIkey="ModelValue_145"/>
    <SBMLMap SBMLid="PGM1_keq" COPASIkey="ModelValue_144"/>
    <SBMLMap SBMLid="PPASE_f" COPASIkey="ModelValue_130"/>
    <SBMLMap SBMLid="PPASE_k_ppi" COPASIkey="ModelValue_131"/>
    <SBMLMap SBMLid="PPASE_n" COPASIkey="ModelValue_132"/>
    <SBMLMap SBMLid="REF_P" COPASIkey="ModelValue_19"/>
    <SBMLMap SBMLid="UGALP_f" COPASIkey="ModelValue_126"/>
    <SBMLMap SBMLid="UGP_f" COPASIkey="ModelValue_110"/>
    <SBMLMap SBMLid="UGP_k_gal1p" COPASIkey="ModelValue_116"/>
    <SBMLMap SBMLid="UGP_k_glc1p" COPASIkey="ModelValue_113"/>
    <SBMLMap SBMLid="UGP_k_ppi" COPASIkey="ModelValue_115"/>
    <SBMLMap SBMLid="UGP_k_udpgal" COPASIkey="ModelValue_117"/>
    <SBMLMap SBMLid="UGP_k_udpglc" COPASIkey="ModelValue_114"/>
    <SBMLMap SBMLid="UGP_k_utp" COPASIkey="ModelValue_112"/>
    <SBMLMap SBMLid="UGP_keq" COPASIkey="ModelValue_111"/>
    <SBMLMap SBMLid="UGP_ki_udpglc" COPASIkey="ModelValue_119"/>
    <SBMLMap SBMLid="UGP_ki_utp" COPASIkey="ModelValue_118"/>
    <SBMLMap SBMLid="Vol_c" COPASIkey="ModelValue_22"/>
    <SBMLMap SBMLid="Vol_e" COPASIkey="ModelValue_21"/>
    <SBMLMap SBMLid="Vol_h" COPASIkey="ModelValue_24"/>
    <SBMLMap SBMLid="c" COPASIkey="Compartment_9"/>
    <SBMLMap SBMLid="c__ALDR" COPASIkey="Reaction_12"/>
    <SBMLMap SBMLid="c__ALDRM" COPASIkey="Reaction_13"/>
    <SBMLMap SBMLid="c__ALDR_P" COPASIkey="ModelValue_71"/>
    <SBMLMap SBMLid="c__ALDR_V" COPASIkey="ModelValue_73"/>
    <SBMLMap SBMLid="c__ALDR_Vb" COPASIkey="ModelValue_72"/>
    <SBMLMap SBMLid="c__ALDR_Vf" COPASIkey="ModelValue_76"/>
    <SBMLMap SBMLid="c__ALDR_Vmax" COPASIkey="ModelValue_74"/>
    <SBMLMap SBMLid="c__ALDR_dm" COPASIkey="ModelValue_75"/>
    <SBMLMap SBMLid="c__ATPS" COPASIkey="Reaction_11"/>
    <SBMLMap SBMLid="c__ATPS_P" COPASIkey="ModelValue_63"/>
    <SBMLMap SBMLid="c__ATPS_Vmax" COPASIkey="ModelValue_64"/>
    <SBMLMap SBMLid="c__GALE" COPASIkey="Reaction_19"/>
    <SBMLMap SBMLid="c__GALEM" COPASIkey="Reaction_20"/>
    <SBMLMap SBMLid="c__GALE_P" COPASIkey="ModelValue_104"/>
    <SBMLMap SBMLid="c__GALE_V" COPASIkey="ModelValue_106"/>
    <SBMLMap SBMLid="c__GALE_Vb" COPASIkey="ModelValue_105"/>
    <SBMLMap SBMLid="c__GALE_Vf" COPASIkey="ModelValue_109"/>
    <SBMLMap SBMLid="c__GALE_Vmax" COPASIkey="ModelValue_107"/>
    <SBMLMap SBMLid="c__GALE_dm" COPASIkey="ModelValue_108"/>
    <SBMLMap SBMLid="c__GALK" COPASIkey="Reaction_7"/>
    <SBMLMap SBMLid="c__GALKM" COPASIkey="Reaction_8"/>
    <SBMLMap SBMLid="c__GALK_P" COPASIkey="ModelValue_46"/>
    <SBMLMap SBMLid="c__GALK_V" COPASIkey="ModelValue_47"/>
    <SBMLMap SBMLid="c__GALK_Vb" COPASIkey="ModelValue_48"/>
    <SBMLMap SBMLid="c__GALK_Vf" COPASIkey="ModelValue_51"/>
    <SBMLMap SBMLid="c__GALK_Vmax" COPASIkey="ModelValue_49"/>
    <SBMLMap SBMLid="c__GALK_dm" COPASIkey="ModelValue_50"/>
    <SBMLMap SBMLid="c__GALT" COPASIkey="Reaction_15"/>
    <SBMLMap SBMLid="c__GALTM1" COPASIkey="Reaction_16"/>
    <SBMLMap SBMLid="c__GALTM2" COPASIkey="Reaction_17"/>
    <SBMLMap SBMLid="c__GALTM3" COPASIkey="Reaction_18"/>
    <SBMLMap SBMLid="c__GALT_P" COPASIkey="ModelValue_92"/>
    <SBMLMap SBMLid="c__GALT_V" COPASIkey="ModelValue_94"/>
    <SBMLMap SBMLid="c__GALT_Vb" COPASIkey="ModelValue_96"/>
    <SBMLMap SBMLid="c__GALT_Vf" COPASIkey="ModelValue_93"/>
    <SBMLMap SBMLid="c__GALT_Vmax" COPASIkey="ModelValue_95"/>
    <SBMLMap SBMLid="c__GALT_dm" COPASIkey="ModelValue_97"/>
    <SBMLMap SBMLid="c__GLUT2_P" COPASIkey="ModelValue_170"/>
    <SBMLMap SBMLid="c__GLUT2_V" COPASIkey="ModelValue_173"/>
    <SBMLMap SBMLid="c__GLUT2_Vb" COPASIkey="ModelValue_172"/>
    <SBMLMap SBMLid="c__GLUT2_Vf" COPASIkey="ModelValue_174"/>
    <SBMLMap SBMLid="c__GLUT2_Vmax" COPASIkey="ModelValue_175"/>
    <SBMLMap SBMLid="c__GLUT2_dm" COPASIkey="ModelValue_171"/>
    <SBMLMap SBMLid="c__GLY" COPASIkey="Reaction_29"/>
    <SBMLMap SBMLid="c__GLYM" COPASIkey="Reaction_30"/>
    <SBMLMap SBMLid="c__GLY_P" COPASIkey="ModelValue_156"/>
    <SBMLMap SBMLid="c__GLY_Vmax" COPASIkey="ModelValue_157"/>
    <SBMLMap SBMLid="c__GTFGAL" COPASIkey="Reaction_31"/>
    <SBMLMap SBMLid="c__GTFGALM" COPASIkey="Reaction_32"/>
    <SBMLMap SBMLid="c__GTFGAL_Vf" COPASIkey="ModelValue_162"/>
    <SBMLMap SBMLid="c__GTFGLC" COPASIkey="Reaction_33"/>
    <SBMLMap SBMLid="c__GTFGLCM" COPASIkey="Reaction_34"/>
    <SBMLMap SBMLid="c__GTFGLC_Vf" COPASIkey="ModelValue_164"/>
    <SBMLMap SBMLid="c__GTF_P" COPASIkey="ModelValue_161"/>
    <SBMLMap SBMLid="c__GTF_Vmax" COPASIkey="ModelValue_163"/>
    <SBMLMap SBMLid="c__H2OT_Vmax" COPASIkey="ModelValue_167"/>
    <SBMLMap SBMLid="c__IMP" COPASIkey="Reaction_9"/>
    <SBMLMap SBMLid="c__IMPM" COPASIkey="Reaction_10"/>
    <SBMLMap SBMLid="c__IMP_P" COPASIkey="ModelValue_54"/>
    <SBMLMap SBMLid="c__IMP_Vf" COPASIkey="ModelValue_56"/>
    <SBMLMap SBMLid="c__IMP_Vmax" COPASIkey="ModelValue_57"/>
    <SBMLMap SBMLid="c__IMP_dm" COPASIkey="ModelValue_55"/>
    <SBMLMap SBMLid="c__NADPR" COPASIkey="Reaction_14"/>
    <SBMLMap SBMLid="c__NADPR_P" COPASIkey="ModelValue_81"/>
    <SBMLMap SBMLid="c__NADPR_Vmax" COPASIkey="ModelValue_82"/>
    <SBMLMap SBMLid="c__NDKU" COPASIkey="Reaction_26"/>
    <SBMLMap SBMLid="c__NDKU_P" COPASIkey="ModelValue_141"/>
    <SBMLMap SBMLid="c__NDKU_Vmax" COPASIkey="ModelValue_142"/>
    <SBMLMap SBMLid="c__PGM1" COPASIkey="Reaction_27"/>
    <SBMLMap SBMLid="c__PGM1M" COPASIkey="Reaction_28"/>
    <SBMLMap SBMLid="c__PGM1_P" COPASIkey="ModelValue_147"/>
    <SBMLMap SBMLid="c__PGM1_V" COPASIkey="ModelValue_149"/>
    <SBMLMap SBMLid="c__PGM1_Vb" COPASIkey="ModelValue_148"/>
    <SBMLMap SBMLid="c__PGM1_Vf" COPASIkey="ModelValue_152"/>
    <SBMLMap SBMLid="c__PGM1_Vmax" COPASIkey="ModelValue_150"/>
    <SBMLMap SBMLid="c__PGM1_dm" COPASIkey="ModelValue_151"/>
    <SBMLMap SBMLid="c__PPASE" COPASIkey="Reaction_25"/>
    <SBMLMap SBMLid="c__PPASE_P" COPASIkey="ModelValue_133"/>
    <SBMLMap SBMLid="c__PPASE_Vmax" COPASIkey="ModelValue_134"/>
    <SBMLMap SBMLid="c__UGALP" COPASIkey="Reaction_23"/>
    <SBMLMap SBMLid="c__UGALPM" COPASIkey="Reaction_24"/>
    <SBMLMap SBMLid="c__UGALP_V" COPASIkey="ModelValue_128"/>
    <SBMLMap SBMLid="c__UGALP_Vb" COPASIkey="ModelValue_127"/>
    <SBMLMap SBMLid="c__UGALP_Vf" COPASIkey="ModelValue_129"/>
    <SBMLMap SBMLid="c__UGP" COPASIkey="Reaction_21"/>
    <SBMLMap SBMLid="c__UGPM" COPASIkey="Reaction_22"/>
    <SBMLMap SBMLid="c__UGP_P" COPASIkey="ModelValue_120"/>
    <SBMLMap SBMLid="c__UGP_V" COPASIkey="ModelValue_122"/>
    <SBMLMap SBMLid="c__UGP_Vb" COPASIkey="ModelValue_125"/>
    <SBMLMap SBMLid="c__UGP_Vf" COPASIkey="ModelValue_121"/>
    <SBMLMap SBMLid="c__UGP_Vmax" COPASIkey="ModelValue_123"/>
    <SBMLMap SBMLid="c__UGP_dm" COPASIkey="ModelValue_124"/>
    <SBMLMap SBMLid="c__acpt" COPASIkey="Metabolite_21"/>
    <SBMLMap SBMLid="c__acptgal" COPASIkey="Metabolite_19"/>
    <SBMLMap SBMLid="c__acptgalM" COPASIkey="Metabolite_37"/>
    <SBMLMap SBMLid="c__acptglc" COPASIkey="Metabolite_39"/>
    <SBMLMap SBMLid="c__acptglcM" COPASIkey="Metabolite_79"/>
    <SBMLMap SBMLid="c__adp" COPASIkey="Metabolite_49"/>
    <SBMLMap SBMLid="c__adp_bal" COPASIkey="ModelValue_28"/>
    <SBMLMap SBMLid="c__atp" COPASIkey="Metabolite_27"/>
    <SBMLMap SBMLid="c__co2" COPASIkey="Metabolite_53"/>
    <SBMLMap SBMLid="c__gal" COPASIkey="Metabolite_35"/>
    <SBMLMap SBMLid="c__gal1p" COPASIkey="Metabolite_75"/>
    <SBMLMap SBMLid="c__gal1pM" COPASIkey="Metabolite_33"/>
    <SBMLMap SBMLid="c__gal1p_tot" COPASIkey="ModelValue_31"/>
    <SBMLMap SBMLid="c__galM" COPASIkey="Metabolite_61"/>
    <SBMLMap SBMLid="c__gal_tot" COPASIkey="ModelValue_25"/>
    <SBMLMap SBMLid="c__galtol" COPASIkey="Metabolite_63"/>
    <SBMLMap SBMLid="c__galtolM" COPASIkey="Metabolite_41"/>
    <SBMLMap SBMLid="c__galtol_tot" COPASIkey="ModelValue_33"/>
    <SBMLMap SBMLid="c__glc1p" COPASIkey="Metabolite_17"/>
    <SBMLMap SBMLid="c__glc1pM" COPASIkey="Metabolite_69"/>
    <SBMLMap SBMLid="c__glc1p_tot" COPASIkey="ModelValue_34"/>
    <SBMLMap SBMLid="c__glc6p" COPASIkey="Metabolite_47"/>
    <SBMLMap SBMLid="c__glc6pM" COPASIkey="Metabolite_67"/>
    <SBMLMap SBMLid="c__glc6p_tot" COPASIkey="ModelValue_30"/>
    <SBMLMap SBMLid="c__h2" COPASIkey="Metabolite_77"/>
    <SBMLMap SBMLid="c__h2o" COPASIkey="Metabolite_73"/>
    <SBMLMap SBMLid="c__hydron" COPASIkey="Metabolite_57"/>
    <SBMLMap SBMLid="c__nadp" COPASIkey="Metabolite_55"/>
    <SBMLMap SBMLid="c__nadp_bal" COPASIkey="ModelValue_37"/>
    <SBMLMap SBMLid="c__nadph" COPASIkey="Metabolite_65"/>
    <SBMLMap SBMLid="c__o2" COPASIkey="Metabolite_45"/>
    <SBMLMap SBMLid="c__phos" COPASIkey="Metabolite_83"/>
    <SBMLMap SBMLid="c__phos_bal" COPASIkey="ModelValue_29"/>
    <SBMLMap SBMLid="c__ppi" COPASIkey="Metabolite_13"/>
    <SBMLMap SBMLid="c__scale" COPASIkey="ModelValue_32"/>
    <SBMLMap SBMLid="c__udp" COPASIkey="Metabolite_25"/>
    <SBMLMap SBMLid="c__udp_bal" COPASIkey="ModelValue_36"/>
    <SBMLMap SBMLid="c__udpgal" COPASIkey="Metabolite_23"/>
    <SBMLMap SBMLid="c__udpgalM" COPASIkey="Metabolite_59"/>
    <SBMLMap SBMLid="c__udpgal_tot" COPASIkey="ModelValue_35"/>
    <SBMLMap SBMLid="c__udpglc" COPASIkey="Metabolite_71"/>
    <SBMLMap SBMLid="c__udpglcM" COPASIkey="Metabolite_81"/>
    <SBMLMap SBMLid="c__udpglc_tot" COPASIkey="ModelValue_27"/>
    <SBMLMap SBMLid="c__utp" COPASIkey="Metabolite_29"/>
    <SBMLMap SBMLid="deficiency" COPASIkey="ModelValue_18"/>
    <SBMLMap SBMLid="e" COPASIkey="Compartment_11"/>
    <SBMLMap SBMLid="e__GLUT2_GAL" COPASIkey="Reaction_36"/>
    <SBMLMap SBMLid="e__GLUT2_GALM" COPASIkey="Reaction_37"/>
    <SBMLMap SBMLid="e__H2OTM" COPASIkey="Reaction_35"/>
    <SBMLMap SBMLid="e__gal" COPASIkey="Metabolite_31"/>
    <SBMLMap SBMLid="e__galM" COPASIkey="Metabolite_43"/>
    <SBMLMap SBMLid="e__gal_tot" COPASIkey="ModelValue_26"/>
    <SBMLMap SBMLid="e__h2oM" COPASIkey="Metabolite_15"/>
    <SBMLMap SBMLid="f_cyto" COPASIkey="ModelValue_16"/>
    <SBMLMap SBMLid="f_tissue" COPASIkey="ModelValue_20"/>
    <SBMLMap SBMLid="h" COPASIkey="Compartment_7"/>
    <SBMLMap SBMLid="h__h2oM" COPASIkey="Metabolite_51"/>
    <SBMLMap SBMLid="m" COPASIkey="Compartment_13"/>
    <SBMLMap SBMLid="scale_f" COPASIkey="ModelValue_13"/>
    <SBMLMap SBMLid="x_cell" COPASIkey="ModelValue_15"/>
    <SBMLMap SBMLid="y_cell" COPASIkey="ModelValue_14"/>
  </SBMLReference>
</COPASI>
