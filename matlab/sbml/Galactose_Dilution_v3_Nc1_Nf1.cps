<?xml version="1.0" encoding="UTF-8"?>
<!-- generated with COPASI 4.11 (Build 65) (http://www.copasi.org) at 2014-03-12 15:48:31 UTC -->
<?oxygen RNGSchema="http://www.copasi.org/static/schema/CopasiML.rng" type="xml"?>
<COPASI xmlns="http://www.copasi.org/static/schema" versionMajor="4" versionMinor="11" versionDevel="65" copasiSourcesModified="0">
  <ListOfFunctions>
    <Function key="Function_40" name="Function for FlowPPS001_rbcM" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*PP__rbcM*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_246" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_258" name="PP__rbcM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_265" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_41" name="Function for FlowS001PV_rbcM" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*S001__rbcM*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_269" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_270" name="S001__rbcM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_271" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_42" name="Function for FlowPVNULL_rbcM" type="UserDefined" reversible="true">
      <Expression>
        flow_sin*PV__rbcM*A_sin/PV
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_276" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_277" name="PV" order="1" role="volume"/>
        <ParameterDescription key="FunctionParameter_278" name="PV__rbcM" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_279" name="flow_sin" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_43" name="Function for FlowPPS001_suc" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*PP__suc*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_254" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_284" name="PP__suc" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_285" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_44" name="Function for FlowS001PV_suc" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*S001__suc*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_289" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_290" name="S001__suc" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_291" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_45" name="Function for FlowPVNULL_suc" type="UserDefined" reversible="true">
      <Expression>
        flow_sin*PV__suc*A_sin/PV
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_296" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_297" name="PV" order="1" role="volume"/>
        <ParameterDescription key="FunctionParameter_298" name="PV__suc" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_299" name="flow_sin" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_46" name="Function for FlowPPS001_alb" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*PP__alb*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_275" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_304" name="PP__alb" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_305" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_47" name="Function for FlowS001PV_alb" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*S001__alb*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_309" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_310" name="S001__alb" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_311" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_48" name="Function for FlowPVNULL_alb" type="UserDefined" reversible="true">
      <Expression>
        flow_sin*PV__alb*A_sin/PV
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_316" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_317" name="PV" order="1" role="volume"/>
        <ParameterDescription key="FunctionParameter_318" name="PV__alb" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_319" name="flow_sin" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_49" name="Function for FlowPPS001_gal" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*PP__gal*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_295" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_324" name="PP__gal" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_325" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_50" name="Function for FlowS001PV_gal" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*S001__gal*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_329" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_330" name="S001__gal" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_331" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_51" name="Function for FlowPVNULL_gal" type="UserDefined" reversible="true">
      <Expression>
        flow_sin*PV__gal*A_sin/PV
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_336" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_337" name="PV" order="1" role="volume"/>
        <ParameterDescription key="FunctionParameter_338" name="PV__gal" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_339" name="flow_sin" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_52" name="Function for FlowPPS001_galM" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*PP__galM*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_315" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_344" name="PP__galM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_345" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_53" name="Function for FlowS001PV_galM" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*S001__galM*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_349" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_350" name="S001__galM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_351" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_54" name="Function for FlowPVNULL_galM" type="UserDefined" reversible="true">
      <Expression>
        flow_sin*PV__galM*A_sin/PV
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_356" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_357" name="PV" order="1" role="volume"/>
        <ParameterDescription key="FunctionParameter_358" name="PV__galM" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_359" name="flow_sin" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_55" name="Function for FlowPPS001_h2oM" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*PP__h2oM*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_335" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_364" name="PP__h2oM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_365" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_56" name="Function for FlowS001PV_h2oM" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*S001__h2oM*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_369" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_370" name="S001__h2oM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_371" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_57" name="Function for FlowPVNULL_h2oM" type="UserDefined" reversible="true">
      <Expression>
        flow_sin*PV__h2oM*A_sin/PV
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_376" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_377" name="PV" order="1" role="volume"/>
        <ParameterDescription key="FunctionParameter_378" name="PV__h2oM" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_379" name="flow_sin" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_58" name="Function for DiffPPS001_rbcM" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_rbcM*(PP__rbcM-S001__rbcM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_355" name="Dx_sin_rbcM" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_384" name="PP__rbcM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_385" name="S001__rbcM" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_59" name="Function for DiffS001PV_rbcM" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_rbcM*(S001__rbcM-PV__rbcM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_389" name="Dx_sin_rbcM" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_390" name="PV__rbcM" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_391" name="S001__rbcM" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_60" name="Function for DiffS001D001_rbcM" type="UserDefined" reversible="true">
      <Expression>
        Dy_sindis_rbcM*(S001__rbcM-D001__rbcM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_395" name="D001__rbcM" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_396" name="Dy_sindis_rbcM" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_397" name="S001__rbcM" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_61" name="Function for DiffPPS001_suc" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_suc*(PP__suc-S001__suc)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_401" name="Dx_sin_suc" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_402" name="PP__suc" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_403" name="S001__suc" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_62" name="Function for DiffS001PV_suc" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_suc*(S001__suc-PV__suc)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_407" name="Dx_sin_suc" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_408" name="PV__suc" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_409" name="S001__suc" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_63" name="Function for DiffS001D001_suc" type="UserDefined" reversible="true">
      <Expression>
        Dy_sindis_suc*(S001__suc-D001__suc)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_413" name="D001__suc" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_414" name="Dy_sindis_suc" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_415" name="S001__suc" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_64" name="Function for DiffPPS001_alb" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_alb*(PP__alb-S001__alb)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_419" name="Dx_sin_alb" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_420" name="PP__alb" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_421" name="S001__alb" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_65" name="Function for DiffS001PV_alb" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_alb*(S001__alb-PV__alb)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_425" name="Dx_sin_alb" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_426" name="PV__alb" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_427" name="S001__alb" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_66" name="Function for DiffS001D001_alb" type="UserDefined" reversible="true">
      <Expression>
        Dy_sindis_alb*(S001__alb-D001__alb)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_431" name="D001__alb" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_432" name="Dy_sindis_alb" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_433" name="S001__alb" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_67" name="Function for DiffPPS001_gal" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_gal*(PP__gal-S001__gal)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_437" name="Dx_sin_gal" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_438" name="PP__gal" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_439" name="S001__gal" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_68" name="Function for DiffS001PV_gal" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_gal*(S001__gal-PV__gal)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_443" name="Dx_sin_gal" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_444" name="PV__gal" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_445" name="S001__gal" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_69" name="Function for DiffS001D001_gal" type="UserDefined" reversible="true">
      <Expression>
        Dy_sindis_gal*(S001__gal-D001__gal)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_449" name="D001__gal" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_450" name="Dy_sindis_gal" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_451" name="S001__gal" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_70" name="Function for DiffPPS001_galM" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_galM*(PP__galM-S001__galM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_455" name="Dx_sin_galM" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_456" name="PP__galM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_457" name="S001__galM" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_71" name="Function for DiffS001PV_galM" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_galM*(S001__galM-PV__galM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_461" name="Dx_sin_galM" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_462" name="PV__galM" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_463" name="S001__galM" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_72" name="Function for DiffS001D001_galM" type="UserDefined" reversible="true">
      <Expression>
        Dy_sindis_galM*(S001__galM-D001__galM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_467" name="D001__galM" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_468" name="Dy_sindis_galM" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_469" name="S001__galM" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_73" name="Function for DiffPPS001_h2oM" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_h2oM*(PP__h2oM-S001__h2oM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_473" name="Dx_sin_h2oM" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_474" name="PP__h2oM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_475" name="S001__h2oM" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_74" name="Function for DiffS001PV_h2oM" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_h2oM*(S001__h2oM-PV__h2oM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_479" name="Dx_sin_h2oM" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_480" name="PV__h2oM" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_481" name="S001__h2oM" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_75" name="Function for DiffS001D001_h2oM" type="UserDefined" reversible="true">
      <Expression>
        Dy_sindis_h2oM*(S001__h2oM-D001__h2oM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_485" name="D001__h2oM" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_486" name="Dy_sindis_h2oM" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_487" name="S001__h2oM" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_76" name="Function for Galactokinase (H01)" type="UserDefined" reversible="true">
      <Expression>
        H01__GALK_Vmax/(GALK_k_gal*GALK_k_atp)*1/(1+H01__gal1p/GALK_ki_gal1p)*(H01__gal*H01__atp-H01__gal1p*H01__adp/GALK_keq)/H01__GALK_dm/H01
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_499" name="GALK_k_atp" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_500" name="GALK_k_gal" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_501" name="GALK_keq" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_502" name="GALK_ki_gal1p" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_503" name="H01" order="4" role="volume"/>
        <ParameterDescription key="FunctionParameter_504" name="H01__GALK_Vmax" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_505" name="H01__GALK_dm" order="6" role="constant"/>
        <ParameterDescription key="FunctionParameter_506" name="H01__adp" order="7" role="product"/>
        <ParameterDescription key="FunctionParameter_507" name="H01__atp" order="8" role="substrate"/>
        <ParameterDescription key="FunctionParameter_508" name="H01__gal" order="9" role="substrate"/>
        <ParameterDescription key="FunctionParameter_509" name="H01__gal1p" order="10" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_77" name="Function for Galactokinase (H01)_2" type="UserDefined" reversible="false">
      <Expression>
        H01__GALK_Vmax/(GALK_k_gal*GALK_k_atp)*1/(1+H01__gal1p/GALK_ki_gal1p)*H01__galM*H01__atp/H01__GALK_dm/H01
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_262" name="GALK_k_atp" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_375" name="GALK_k_gal" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_521" name="GALK_ki_gal1p" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_522" name="H01" order="3" role="volume"/>
        <ParameterDescription key="FunctionParameter_523" name="H01__GALK_Vmax" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_524" name="H01__GALK_dm" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_525" name="H01__atp" order="6" role="substrate"/>
        <ParameterDescription key="FunctionParameter_526" name="H01__gal1p" order="7" role="product"/>
        <ParameterDescription key="FunctionParameter_527" name="H01__galM" order="8" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_78" name="Function for Inositol monophosphatase (H01)" type="UserDefined" reversible="false">
      <Expression>
        H01__IMP_Vmax/IMP_k_gal1p*H01__gal1p/(1+H01__gal1p/IMP_k_gal1p)/H01
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_491" name="H01" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_496" name="H01__IMP_Vmax" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_497" name="H01__gal1p" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_493" name="IMP_k_gal1p" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_79" name="Function for ATP synthase (H01)" type="UserDefined" reversible="true">
      <Expression>
        H01__ATPS_Vmax/(ATPS_k_adp*ATPS_k_phos)*(H01__adp*H01__phos-H01__atp/ATPS_keq)/((1+H01__adp/ATPS_k_adp)*(1+H01__phos/ATPS_k_phos)+H01__atp/ATPS_k_atp)/H01
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_545" name="ATPS_k_adp" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_546" name="ATPS_k_atp" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_547" name="ATPS_k_phos" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_548" name="ATPS_keq" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_549" name="H01" order="4" role="volume"/>
        <ParameterDescription key="FunctionParameter_550" name="H01__ATPS_Vmax" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_551" name="H01__adp" order="6" role="substrate"/>
        <ParameterDescription key="FunctionParameter_552" name="H01__atp" order="7" role="product"/>
        <ParameterDescription key="FunctionParameter_553" name="H01__phos" order="8" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_80" name="Function for Aldose reductase (H01)" type="UserDefined" reversible="true">
      <Expression>
        H01__ALDR_Vmax/(ALDR_k_gal*ALDR_k_nadp)*(H01__gal*H01__nadph-H01__galtol*H01__nadp/ALDR_keq)/((1+H01__gal/ALDR_k_gal)*(1+H01__nadph/ALDR_k_nadph)+(1+H01__galtol/ALDR_k_galtol)*(1+H01__nadp/ALDR_k_nadp)-1)/H01
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_565" name="ALDR_k_gal" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_566" name="ALDR_k_galtol" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_567" name="ALDR_k_nadp" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_568" name="ALDR_k_nadph" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_569" name="ALDR_keq" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_570" name="H01" order="5" role="volume"/>
        <ParameterDescription key="FunctionParameter_571" name="H01__ALDR_Vmax" order="6" role="constant"/>
        <ParameterDescription key="FunctionParameter_572" name="H01__gal" order="7" role="substrate"/>
        <ParameterDescription key="FunctionParameter_573" name="H01__galtol" order="8" role="product"/>
        <ParameterDescription key="FunctionParameter_574" name="H01__nadp" order="9" role="product"/>
        <ParameterDescription key="FunctionParameter_575" name="H01__nadph" order="10" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_81" name="Function for NADP Reductase (H01)" type="UserDefined" reversible="false">
      <Expression>
        H01__NADPR_Vmax/NADPR_k_nadp*(H01__nadp-H01__nadph/NADPR_keq)/(1+H01__nadp/NADPR_k_nadp+H01__nadph/NADPR_ki_nadph)/H01
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_498" name="H01" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_492" name="H01__NADPR_Vmax" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_563" name="H01__nadp" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_541" name="H01__nadph" order="3" role="product"/>
        <ParameterDescription key="FunctionParameter_587" name="NADPR_k_nadp" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_588" name="NADPR_keq" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_589" name="NADPR_ki_nadph" order="6" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_82" name="Function for Galactose-1-phosphate uridyl transferase (H01)" type="UserDefined" reversible="true">
      <Expression>
        H01__GALT_Vmax/(GALT_k_gal1p*GALT_k_udpglc)*(H01__gal1p*H01__udpglc-H01__glc1p*H01__udpgal/GALT_keq)/((1+H01__gal1p/GALT_k_gal1p)*(1+H01__udpglc/GALT_k_udpglc+H01__udp/GALT_ki_udp+H01__utp/GALT_ki_utp)+(1+H01__glc1p/GALT_k_glc1p)*(1+H01__udpgal/GALT_k_udpgal)-1)/H01
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_605" name="GALT_k_gal1p" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_606" name="GALT_k_glc1p" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_607" name="GALT_k_udpgal" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_608" name="GALT_k_udpglc" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_609" name="GALT_keq" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_610" name="GALT_ki_udp" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_611" name="GALT_ki_utp" order="6" role="constant"/>
        <ParameterDescription key="FunctionParameter_612" name="H01" order="7" role="volume"/>
        <ParameterDescription key="FunctionParameter_613" name="H01__GALT_Vmax" order="8" role="constant"/>
        <ParameterDescription key="FunctionParameter_614" name="H01__gal1p" order="9" role="substrate"/>
        <ParameterDescription key="FunctionParameter_615" name="H01__glc1p" order="10" role="product"/>
        <ParameterDescription key="FunctionParameter_616" name="H01__udp" order="11" role="modifier"/>
        <ParameterDescription key="FunctionParameter_617" name="H01__udpgal" order="12" role="product"/>
        <ParameterDescription key="FunctionParameter_618" name="H01__udpglc" order="13" role="substrate"/>
        <ParameterDescription key="FunctionParameter_619" name="H01__utp" order="14" role="modifier"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_83" name="Function for UDP-glucose 4-epimerase (H01)" type="UserDefined" reversible="true">
      <Expression>
        H01__GALE_Vmax/GALE_k_udpglc*(H01__udpglc-H01__udpgal/GALE_keq)/(1+H01__udpglc/GALE_k_udpglc+H01__udpgal/GALE_k_udpgal)/H01
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_604" name="GALE_k_udpgal" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_601" name="GALE_k_udpglc" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_599" name="GALE_keq" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_597" name="H01" order="3" role="volume"/>
        <ParameterDescription key="FunctionParameter_264" name="H01__GALE_Vmax" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_603" name="H01__udpgal" order="5" role="product"/>
        <ParameterDescription key="FunctionParameter_602" name="H01__udpglc" order="6" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_84" name="Function for UDP-glucose pyrophosphorylase (H01)" type="UserDefined" reversible="true">
      <Expression>
        H01__UGP_Vmax/(UGP_k_utp*UGP_k_glc1p)*(H01__glc1p*H01__utp-H01__udpglc*H01__ppi/UGP_keq)/H01__UGP_dm/H01
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_644" name="H01" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_645" name="H01__UGP_Vmax" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_646" name="H01__UGP_dm" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_647" name="H01__glc1p" order="3" role="substrate"/>
        <ParameterDescription key="FunctionParameter_648" name="H01__ppi" order="4" role="product"/>
        <ParameterDescription key="FunctionParameter_649" name="H01__udpglc" order="5" role="product"/>
        <ParameterDescription key="FunctionParameter_650" name="H01__utp" order="6" role="substrate"/>
        <ParameterDescription key="FunctionParameter_651" name="UGP_k_glc1p" order="7" role="constant"/>
        <ParameterDescription key="FunctionParameter_652" name="UGP_k_utp" order="8" role="constant"/>
        <ParameterDescription key="FunctionParameter_653" name="UGP_keq" order="9" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_85" name="Function for UDP-galactose pyrophosphorylase (H01)" type="UserDefined" reversible="true">
      <Expression>
        UGALP_f*H01__UGP_Vmax/(UGP_k_utp*UGP_k_gal1p)*(H01__gal1p*H01__utp-H01__udpgal*H01__ppi/UGP_keq)/H01__UGP_dm/H01
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_665" name="H01" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_666" name="H01__UGP_Vmax" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_667" name="H01__UGP_dm" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_668" name="H01__gal1p" order="3" role="substrate"/>
        <ParameterDescription key="FunctionParameter_669" name="H01__ppi" order="4" role="product"/>
        <ParameterDescription key="FunctionParameter_670" name="H01__udpgal" order="5" role="product"/>
        <ParameterDescription key="FunctionParameter_671" name="H01__utp" order="6" role="substrate"/>
        <ParameterDescription key="FunctionParameter_672" name="UGALP_f" order="7" role="constant"/>
        <ParameterDescription key="FunctionParameter_673" name="UGP_k_gal1p" order="8" role="constant"/>
        <ParameterDescription key="FunctionParameter_674" name="UGP_k_utp" order="9" role="constant"/>
        <ParameterDescription key="FunctionParameter_675" name="UGP_keq" order="10" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_86" name="Function for Pyrophosphatase (H01)" type="UserDefined" reversible="false">
      <Expression>
        H01__PPASE_Vmax*H01__ppi^PPASE_n/(H01__ppi^PPASE_n+PPASE_k_ppi^PPASE_n)/H01
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_564" name="H01" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_642" name="H01__PPASE_Vmax" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_542" name="H01__ppi" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_643" name="PPASE_k_ppi" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_598" name="PPASE_n" order="4" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_87" name="Function for ATP:UDP phosphotransferase (H01)" type="UserDefined" reversible="true">
      <Expression>
        H01__NDKU_Vmax/NDKU_k_atp/NDKU_k_udp*(H01__atp*H01__udp-H01__adp*H01__utp/NDKU_keq)/((1+H01__atp/NDKU_k_atp)*(1+H01__udp/NDKU_k_udp)+(1+H01__adp/NDKU_k_adp)*(1+H01__utp/NDKU_k_utp)-1)/H01
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_697" name="H01" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_698" name="H01__NDKU_Vmax" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_699" name="H01__adp" order="2" role="product"/>
        <ParameterDescription key="FunctionParameter_700" name="H01__atp" order="3" role="substrate"/>
        <ParameterDescription key="FunctionParameter_701" name="H01__udp" order="4" role="substrate"/>
        <ParameterDescription key="FunctionParameter_702" name="H01__utp" order="5" role="product"/>
        <ParameterDescription key="FunctionParameter_703" name="NDKU_k_adp" order="6" role="constant"/>
        <ParameterDescription key="FunctionParameter_704" name="NDKU_k_atp" order="7" role="constant"/>
        <ParameterDescription key="FunctionParameter_705" name="NDKU_k_udp" order="8" role="constant"/>
        <ParameterDescription key="FunctionParameter_706" name="NDKU_k_utp" order="9" role="constant"/>
        <ParameterDescription key="FunctionParameter_707" name="NDKU_keq" order="10" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_88" name="Function for Phosphoglucomutase-1 (H01)" type="UserDefined" reversible="true">
      <Expression>
        H01__PGM1_Vmax/PGM1_k_glc1p*(H01__glc1p-H01__glc6p/PGM1_keq)/(1+H01__glc1p/PGM1_k_glc1p+H01__glc6p/PGM1_k_glc6p)/H01
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_543" name="H01" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_691" name="H01__PGM1_Vmax" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_544" name="H01__glc1p" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_696" name="H01__glc6p" order="3" role="product"/>
        <ParameterDescription key="FunctionParameter_719" name="PGM1_k_glc1p" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_720" name="PGM1_k_glc6p" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_721" name="PGM1_keq" order="6" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_89" name="Function for Glycolysis (H01)" type="UserDefined" reversible="true">
      <Expression>
        H01__GLY_Vmax*(H01__glc6p-GLY_k_glc6p)/GLY_k_glc6p*H01__phos/(H01__phos+GLY_k_p)/H01
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_495" name="GLY_k_glc6p" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_729" name="GLY_k_p" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_730" name="H01" order="2" role="volume"/>
        <ParameterDescription key="FunctionParameter_731" name="H01__GLY_Vmax" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_732" name="H01__glc6p" order="4" role="substrate"/>
        <ParameterDescription key="FunctionParameter_733" name="H01__phos" order="5" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_90" name="Function for Glycosyltransferase galactose (H01)" type="UserDefined" reversible="false">
      <Expression>
        H01__GTF_Vmax*H01__udpgal/(H01__udpgal+GTF_k_udpgal)/H01
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_600" name="GTF_k_udpgal" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_695" name="H01" order="1" role="volume"/>
        <ParameterDescription key="FunctionParameter_740" name="H01__GTF_Vmax" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_741" name="H01__udpgal" order="3" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_91" name="Function for Glycosyltransferase glucose (H01)" type="UserDefined" reversible="false">
      <Expression>
        0*H01__GTF_Vmax*H01__udpglc/(H01__udpglc+GTF_k_udpglc)/H01
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_746" name="GTF_k_udpglc" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_747" name="H01" order="1" role="volume"/>
        <ParameterDescription key="FunctionParameter_748" name="H01__GTF_Vmax" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_749" name="H01__udpglc" order="3" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_92" name="Function for galactose transport" type="UserDefined" reversible="true">
      <Expression>
        H01__GLUT2_Vmax/(GLUT2_k_gal*Nf)*(D001__gal-H01__gal)/H01__GLUT2_dm
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_756" name="D001__gal" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_757" name="GLUT2_k_gal" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_758" name="H01__GLUT2_Vmax" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_759" name="H01__GLUT2_dm" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_760" name="H01__gal" order="4" role="product"/>
        <ParameterDescription key="FunctionParameter_761" name="Nf" order="5" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_93" name="Function for galactose transport_2" type="UserDefined" reversible="true">
      <Expression>
        H01__GLUT2_Vmax/(GLUT2_k_gal*Nf)*(D001__galM-H01__galM)/H01__GLUT2_dm
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_768" name="D001__galM" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_769" name="GLUT2_k_gal" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_770" name="H01__GLUT2_Vmax" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_771" name="H01__GLUT2_dm" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_772" name="H01__galM" order="4" role="product"/>
        <ParameterDescription key="FunctionParameter_773" name="Nf" order="5" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_94" name="Function for H2O M transport" type="UserDefined" reversible="true">
      <Expression>
        H01__H2OT_Vmax/H2OT_k/Nf*(D001__h2oM-H01__h2oM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_641" name="D001__h2oM" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_780" name="H01__H2OT_Vmax" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_781" name="H01__h2oM" order="2" role="product"/>
        <ParameterDescription key="FunctionParameter_782" name="H2OT_k" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_783" name="Nf" order="4" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
  </ListOfFunctions>
  <Model key="Model_0" name="NoName" simulationType="time" timeUnit="s" volumeUnit="m³" areaUnit="m²" lengthUnit="m" quantityUnit="mol" type="deterministic" avogadroConstant="6.02214179e+23">
    <MiriamAnnotation>
<rdf:RDF
   xmlns:dcterms="http://purl.org/dc/terms/"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Model_0">
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2014-03-12T16:45:04Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
  </rdf:Description>
</rdf:RDF>

    </MiriamAnnotation>
    <ListOfCompartments>
      <Compartment key="Compartment_0" name="PP" simulationType="assignment" dimensionality="3">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[Vol_pp],Reference=Value&gt;
        </Expression>
      </Compartment>
      <Compartment key="Compartment_1" name="S001" simulationType="assignment" dimensionality="3">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[Vol_sin],Reference=Value&gt;
        </Expression>
      </Compartment>
      <Compartment key="Compartment_2" name="D001" simulationType="assignment" dimensionality="3">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[Vol_dis],Reference=Value&gt;
        </Expression>
      </Compartment>
      <Compartment key="Compartment_3" name="PV" simulationType="assignment" dimensionality="3">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[Vol_pv],Reference=Value&gt;
        </Expression>
      </Compartment>
      <Compartment key="Compartment_4" name="H01" simulationType="assignment" dimensionality="3">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[Vol_cell],Reference=Value&gt;
        </Expression>
      </Compartment>
    </ListOfCompartments>
    <ListOfMetabolites>
      <Metabolite key="Metabolite_0" name="rbcM" simulationType="fixed" compartment="Compartment_0">
      </Metabolite>
      <Metabolite key="Metabolite_4" name="suc" simulationType="fixed" compartment="Compartment_0">
      </Metabolite>
      <Metabolite key="Metabolite_8" name="alb" simulationType="fixed" compartment="Compartment_0">
      </Metabolite>
      <Metabolite key="Metabolite_12" name="gal" simulationType="fixed" compartment="Compartment_0">
      </Metabolite>
      <Metabolite key="Metabolite_16" name="galM" simulationType="fixed" compartment="Compartment_0">
      </Metabolite>
      <Metabolite key="Metabolite_20" name="h2oM" simulationType="fixed" compartment="Compartment_0">
      </Metabolite>
      <Metabolite key="Metabolite_1" name="rbcM" simulationType="reactions" compartment="Compartment_1">
      </Metabolite>
      <Metabolite key="Metabolite_5" name="suc" simulationType="reactions" compartment="Compartment_1">
      </Metabolite>
      <Metabolite key="Metabolite_9" name="alb" simulationType="reactions" compartment="Compartment_1">
      </Metabolite>
      <Metabolite key="Metabolite_13" name="gal" simulationType="reactions" compartment="Compartment_1">
      </Metabolite>
      <Metabolite key="Metabolite_17" name="galM" simulationType="reactions" compartment="Compartment_1">
      </Metabolite>
      <Metabolite key="Metabolite_21" name="h2oM" simulationType="reactions" compartment="Compartment_1">
      </Metabolite>
      <Metabolite key="Metabolite_2" name="rbcM" simulationType="reactions" compartment="Compartment_2">
      </Metabolite>
      <Metabolite key="Metabolite_6" name="suc" simulationType="reactions" compartment="Compartment_2">
      </Metabolite>
      <Metabolite key="Metabolite_10" name="alb" simulationType="reactions" compartment="Compartment_2">
      </Metabolite>
      <Metabolite key="Metabolite_14" name="gal" simulationType="reactions" compartment="Compartment_2">
      </Metabolite>
      <Metabolite key="Metabolite_18" name="galM" simulationType="reactions" compartment="Compartment_2">
      </Metabolite>
      <Metabolite key="Metabolite_22" name="h2oM" simulationType="reactions" compartment="Compartment_2">
      </Metabolite>
      <Metabolite key="Metabolite_3" name="rbcM" simulationType="reactions" compartment="Compartment_3">
      </Metabolite>
      <Metabolite key="Metabolite_7" name="suc" simulationType="reactions" compartment="Compartment_3">
      </Metabolite>
      <Metabolite key="Metabolite_11" name="alb" simulationType="reactions" compartment="Compartment_3">
      </Metabolite>
      <Metabolite key="Metabolite_15" name="gal" simulationType="reactions" compartment="Compartment_3">
      </Metabolite>
      <Metabolite key="Metabolite_19" name="galM" simulationType="reactions" compartment="Compartment_3">
      </Metabolite>
      <Metabolite key="Metabolite_23" name="h2oM" simulationType="reactions" compartment="Compartment_3">
      </Metabolite>
      <Metabolite key="Metabolite_24" name="D-galactose" simulationType="reactions" compartment="Compartment_4">
      </Metabolite>
      <Metabolite key="Metabolite_25" name="D-galactose M" simulationType="reactions" compartment="Compartment_4">
      </Metabolite>
      <Metabolite key="Metabolite_26" name="H2O M" simulationType="reactions" compartment="Compartment_4">
      </Metabolite>
      <Metabolite key="Metabolite_27" name="D-glucose-1-phosphate" simulationType="reactions" compartment="Compartment_4">
      </Metabolite>
      <Metabolite key="Metabolite_28" name="D-glucose-6-phosphate" simulationType="reactions" compartment="Compartment_4">
      </Metabolite>
      <Metabolite key="Metabolite_29" name="D-galactose-1-phosphate" simulationType="reactions" compartment="Compartment_4">
      </Metabolite>
      <Metabolite key="Metabolite_30" name="UDP-D-glucose" simulationType="reactions" compartment="Compartment_4">
      </Metabolite>
      <Metabolite key="Metabolite_31" name="UDP-D-galactose" simulationType="reactions" compartment="Compartment_4">
      </Metabolite>
      <Metabolite key="Metabolite_32" name="D-galactitol" simulationType="reactions" compartment="Compartment_4">
      </Metabolite>
      <Metabolite key="Metabolite_33" name="ATP" simulationType="reactions" compartment="Compartment_4">
      </Metabolite>
      <Metabolite key="Metabolite_34" name="ADP" simulationType="reactions" compartment="Compartment_4">
      </Metabolite>
      <Metabolite key="Metabolite_35" name="UTP" simulationType="reactions" compartment="Compartment_4">
      </Metabolite>
      <Metabolite key="Metabolite_36" name="UDP" simulationType="reactions" compartment="Compartment_4">
      </Metabolite>
      <Metabolite key="Metabolite_37" name="Phosphate" simulationType="reactions" compartment="Compartment_4">
      </Metabolite>
      <Metabolite key="Metabolite_38" name="Pyrophosphate" simulationType="reactions" compartment="Compartment_4">
      </Metabolite>
      <Metabolite key="Metabolite_39" name="NADP" simulationType="reactions" compartment="Compartment_4">
      </Metabolite>
      <Metabolite key="Metabolite_40" name="NADPH" simulationType="reactions" compartment="Compartment_4">
      </Metabolite>
    </ListOfMetabolites>
    <ListOfModelValues>
      <ModelValue key="ModelValue_0" name="L" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_1" name="y_sin" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_2" name="y_dis" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_3" name="y_cell" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_4" name="flow_sin" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_5" name="Nc" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_6" name="Nf" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_7" name="Nb" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[Nf],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[Nc],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_8" name="x_cell" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[L],Reference=Value&gt;/&lt;CN=Root,Model=NoName,Vector=Values[Nc],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_9" name="x_sin" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[x_cell],Reference=Value&gt;/&lt;CN=Root,Model=NoName,Vector=Values[Nf],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_10" name="A_sin" simulationType="assignment">
        <Expression>
          PI*&lt;CN=Root,Model=NoName,Vector=Values[y_sin],Reference=Value&gt;^2
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_11" name="A_dis" simulationType="assignment">
        <Expression>
          PI*(&lt;CN=Root,Model=NoName,Vector=Values[y_sin],Reference=Value&gt;+&lt;CN=Root,Model=NoName,Vector=Values[y_dis],Reference=Value&gt;)^2-&lt;CN=Root,Model=NoName,Vector=Values[A_sin],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_12" name="A_sindis" simulationType="assignment">
        <Expression>
          2*PI*&lt;CN=Root,Model=NoName,Vector=Values[y_sin],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[x_sin],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_13" name="Vol_sin" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[A_sin],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[x_sin],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_14" name="Vol_dis" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[A_dis],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[x_sin],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_15" name="Vol_cell" simulationType="assignment">
        <Expression>
          PI*(&lt;CN=Root,Model=NoName,Vector=Values[y_sin],Reference=Value&gt;+&lt;CN=Root,Model=NoName,Vector=Values[y_dis],Reference=Value&gt;+&lt;CN=Root,Model=NoName,Vector=Values[y_cell],Reference=Value&gt;)^2*&lt;CN=Root,Model=NoName,Vector=Values[x_cell],Reference=Value&gt;-PI*(&lt;CN=Root,Model=NoName,Vector=Values[y_sin],Reference=Value&gt;+&lt;CN=Root,Model=NoName,Vector=Values[y_dis],Reference=Value&gt;)^2*&lt;CN=Root,Model=NoName,Vector=Values[x_cell],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_16" name="Vol_pp" simulationType="assignment">
        <Expression>
          10*&lt;CN=Root,Model=NoName,Vector=Values[Vol_sin],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_17" name="Vol_pv" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[Vol_sin],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_18" name="DrbcM" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_19" name="Dx_sin_rbcM" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[DrbcM],Reference=Value&gt;/&lt;CN=Root,Model=NoName,Vector=Values[x_sin],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[A_sin],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_20" name="Dx_dis_rbcM" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[DrbcM],Reference=Value&gt;/&lt;CN=Root,Model=NoName,Vector=Values[x_sin],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[A_dis],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_21" name="Dy_sindis_rbcM" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[DrbcM],Reference=Value&gt;/&lt;CN=Root,Model=NoName,Vector=Values[y_dis],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[A_sindis],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_22" name="Dsuc" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_23" name="Dx_sin_suc" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[Dsuc],Reference=Value&gt;/&lt;CN=Root,Model=NoName,Vector=Values[x_sin],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[A_sin],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_24" name="Dx_dis_suc" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[Dsuc],Reference=Value&gt;/&lt;CN=Root,Model=NoName,Vector=Values[x_sin],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[A_dis],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_25" name="Dy_sindis_suc" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[Dsuc],Reference=Value&gt;/&lt;CN=Root,Model=NoName,Vector=Values[y_dis],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[A_sindis],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_26" name="Dalb" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_27" name="Dx_sin_alb" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[Dalb],Reference=Value&gt;/&lt;CN=Root,Model=NoName,Vector=Values[x_sin],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[A_sin],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_28" name="Dx_dis_alb" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[Dalb],Reference=Value&gt;/&lt;CN=Root,Model=NoName,Vector=Values[x_sin],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[A_dis],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_29" name="Dy_sindis_alb" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[Dalb],Reference=Value&gt;/&lt;CN=Root,Model=NoName,Vector=Values[y_dis],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[A_sindis],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_30" name="Dgal" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_31" name="Dx_sin_gal" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[Dgal],Reference=Value&gt;/&lt;CN=Root,Model=NoName,Vector=Values[x_sin],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[A_sin],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_32" name="Dx_dis_gal" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[Dgal],Reference=Value&gt;/&lt;CN=Root,Model=NoName,Vector=Values[x_sin],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[A_dis],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_33" name="Dy_sindis_gal" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[Dgal],Reference=Value&gt;/&lt;CN=Root,Model=NoName,Vector=Values[y_dis],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[A_sindis],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_34" name="DgalM" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_35" name="Dx_sin_galM" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[DgalM],Reference=Value&gt;/&lt;CN=Root,Model=NoName,Vector=Values[x_sin],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[A_sin],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_36" name="Dx_dis_galM" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[DgalM],Reference=Value&gt;/&lt;CN=Root,Model=NoName,Vector=Values[x_sin],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[A_dis],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_37" name="Dy_sindis_galM" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[DgalM],Reference=Value&gt;/&lt;CN=Root,Model=NoName,Vector=Values[y_dis],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[A_sindis],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_38" name="Dh2oM" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_39" name="Dx_sin_h2oM" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[Dh2oM],Reference=Value&gt;/&lt;CN=Root,Model=NoName,Vector=Values[x_sin],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[A_sin],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_40" name="Dx_dis_h2oM" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[Dh2oM],Reference=Value&gt;/&lt;CN=Root,Model=NoName,Vector=Values[x_sin],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[A_dis],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_41" name="Dy_sindis_h2oM" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[Dh2oM],Reference=Value&gt;/&lt;CN=Root,Model=NoName,Vector=Values[y_dis],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[A_sindis],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_42" name="scale_f" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_43" name="scale" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[scale_f],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_44" name="REF_P" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_45" name="deficiency" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_46" name="H01__nadp_tot" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[NADP],Reference=Concentration&gt;+&lt;CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[NADPH],Reference=Concentration&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_47" name="H01__adp_tot" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[ATP],Reference=Concentration&gt;+&lt;CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[ADP],Reference=Concentration&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_48" name="H01__udp_tot" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[UTP],Reference=Concentration&gt;+&lt;CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[UDP],Reference=Concentration&gt;+&lt;CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[UDP-D-glucose],Reference=Concentration&gt;+&lt;CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[UDP-D-galactose],Reference=Concentration&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_49" name="H01__phos_tot" simulationType="assignment">
        <Expression>
          3*&lt;CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[ATP],Reference=Concentration&gt;+2*&lt;CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[ADP],Reference=Concentration&gt;+3*&lt;CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[UTP],Reference=Concentration&gt;+2*&lt;CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[UDP],Reference=Concentration&gt;+&lt;CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[Phosphate],Reference=Concentration&gt;+2*&lt;CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[Pyrophosphate],Reference=Concentration&gt;+&lt;CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[D-glucose-1-phosphate],Reference=Concentration&gt;+&lt;CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[D-glucose-6-phosphate],Reference=Concentration&gt;+&lt;CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[D-galactose-1-phosphate],Reference=Concentration&gt;+2*&lt;CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[UDP-D-glucose],Reference=Concentration&gt;+2*&lt;CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[UDP-D-galactose],Reference=Concentration&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_50" name="GALK_PA" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_51" name="GALK_keq" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_52" name="GALK_k_gal1p" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_53" name="GALK_k_adp" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_54" name="GALK_ki_gal1p" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_55" name="GALK_kcat" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_56" name="GALK_k_gal" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_57" name="GALK_k_atp" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_58" name="H01__GALK_P" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_59" name="H01__GALK_Vmax" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[scale],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[GALK_PA],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[GALK_kcat],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[H01__GALK_P],Reference=Value&gt;/&lt;CN=Root,Model=NoName,Vector=Values[REF_P],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_60" name="H01__GALK_dm" simulationType="assignment">
        <Expression>
          (1+(&lt;CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[D-galactose],Reference=Concentration&gt;+&lt;CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[D-galactose M],Reference=Concentration&gt;)/&lt;CN=Root,Model=NoName,Vector=Values[GALK_k_gal],Reference=Value&gt;)*(1+&lt;CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[ATP],Reference=Concentration&gt;/&lt;CN=Root,Model=NoName,Vector=Values[GALK_k_atp],Reference=Value&gt;)+(1+&lt;CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[D-galactose-1-phosphate],Reference=Concentration&gt;/&lt;CN=Root,Model=NoName,Vector=Values[GALK_k_gal1p],Reference=Value&gt;)*(1+&lt;CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[ADP],Reference=Concentration&gt;/&lt;CN=Root,Model=NoName,Vector=Values[GALK_k_adp],Reference=Value&gt;)-1
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_61" name="IMP_f" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_62" name="IMP_k_gal1p" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_63" name="H01__IMP_P" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_64" name="H01__IMP_Vmax" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[IMP_f],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[H01__GALK_Vmax],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[H01__IMP_P],Reference=Value&gt;/&lt;CN=Root,Model=NoName,Vector=Values[REF_P],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_65" name="ATPS_f" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_66" name="ATPS_keq" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_67" name="ATPS_k_adp" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_68" name="ATPS_k_atp" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_69" name="ATPS_k_phos" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_70" name="H01__ATPS_P" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_71" name="H01__ATPS_Vmax" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[ATPS_f],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[H01__GALK_Vmax],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[H01__ATPS_P],Reference=Value&gt;/&lt;CN=Root,Model=NoName,Vector=Values[REF_P],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_72" name="ALDR_f" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_73" name="ALDR_keq" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_74" name="ALDR_k_gal" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_75" name="ALDR_k_galtol" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_76" name="ALDR_k_nadp" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_77" name="ALDR_k_nadph" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_78" name="H01__ALDR_P" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_79" name="H01__ALDR_Vmax" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[ALDR_f],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[H01__GALK_Vmax],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[H01__ALDR_P],Reference=Value&gt;/&lt;CN=Root,Model=NoName,Vector=Values[REF_P],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_80" name="NADPR_f" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_81" name="NADPR_keq" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_82" name="NADPR_k_nadp" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_83" name="NADPR_ki_nadph" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_84" name="H01__NADPR_P" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_85" name="H01__NADPR_Vmax" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[NADPR_f],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[H01__ALDR_Vmax],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[H01__NADPR_P],Reference=Value&gt;/&lt;CN=Root,Model=NoName,Vector=Values[REF_P],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_86" name="GALT_f" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_87" name="GALT_keq" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_88" name="GALT_k_glc1p" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_89" name="GALT_k_udpgal" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_90" name="GALT_ki_utp" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_91" name="GALT_ki_udp" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_92" name="GALT_vm" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_93" name="GALT_k_gal1p" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_94" name="GALT_k_udpglc" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_95" name="H01__GALT_P" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_96" name="H01__GALT_Vmax" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[H01__GALT_P],Reference=Value&gt;/&lt;CN=Root,Model=NoName,Vector=Values[REF_P],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[GALT_f],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[H01__GALK_Vmax],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[GALT_vm],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_97" name="GALE_f" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_98" name="GALE_PA" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_99" name="GALE_kcat" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_100" name="GALE_keq" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_101" name="GALE_k_udpglc" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_102" name="GALE_k_udpgal" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_103" name="H01__GALE_P" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_104" name="H01__GALE_Vmax" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[GALE_f],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[H01__GALK_Vmax],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[GALE_PA],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[GALE_kcat],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[H01__GALE_P],Reference=Value&gt;/&lt;CN=Root,Model=NoName,Vector=Values[REF_P],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_105" name="UGP_f" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_106" name="UGALP_f" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_107" name="UGP_keq" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_108" name="UGP_k_utp" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_109" name="UGP_k_glc1p" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_110" name="UGP_k_udpglc" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_111" name="UGP_k_ppi" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_112" name="UGP_k_gal1p" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_113" name="UGP_k_udpgal" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_114" name="UGP_ki_utp" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_115" name="UGP_ki_udpglc" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_116" name="H01__UGP_P" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_117" name="H01__UGP_Vmax" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[UGP_f],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[H01__GALK_Vmax],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[H01__UGP_P],Reference=Value&gt;/&lt;CN=Root,Model=NoName,Vector=Values[REF_P],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_118" name="H01__UGP_dm" simulationType="assignment">
        <Expression>
          (1+&lt;CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[UTP],Reference=Concentration&gt;/&lt;CN=Root,Model=NoName,Vector=Values[UGP_k_utp],Reference=Value&gt;+&lt;CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[UDP-D-glucose],Reference=Concentration&gt;/&lt;CN=Root,Model=NoName,Vector=Values[UGP_ki_udpglc],Reference=Value&gt;)*(1+&lt;CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[D-glucose-1-phosphate],Reference=Concentration&gt;/&lt;CN=Root,Model=NoName,Vector=Values[UGP_k_glc1p],Reference=Value&gt;+&lt;CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[D-galactose-1-phosphate],Reference=Concentration&gt;/&lt;CN=Root,Model=NoName,Vector=Values[UGP_k_gal1p],Reference=Value&gt;)+(1+&lt;CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[UDP-D-glucose],Reference=Concentration&gt;/&lt;CN=Root,Model=NoName,Vector=Values[UGP_k_udpglc],Reference=Value&gt;+&lt;CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[UDP-D-galactose],Reference=Concentration&gt;/&lt;CN=Root,Model=NoName,Vector=Values[UGP_k_udpgal],Reference=Value&gt;+&lt;CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[UTP],Reference=Concentration&gt;/&lt;CN=Root,Model=NoName,Vector=Values[UGP_ki_utp],Reference=Value&gt;)*(1+&lt;CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[Pyrophosphate],Reference=Concentration&gt;/&lt;CN=Root,Model=NoName,Vector=Values[UGP_k_ppi],Reference=Value&gt;)-1
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_119" name="PPASE_f" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_120" name="PPASE_k_ppi" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_121" name="PPASE_n" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_122" name="H01__PPASE_P" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_123" name="H01__PPASE_Vmax" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[PPASE_f],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[H01__UGP_Vmax],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[H01__PPASE_P],Reference=Value&gt;/&lt;CN=Root,Model=NoName,Vector=Values[REF_P],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_124" name="NDKU_f" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_125" name="NDKU_keq" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_126" name="NDKU_k_atp" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_127" name="NDKU_k_adp" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_128" name="NDKU_k_utp" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_129" name="NDKU_k_udp" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_130" name="H01__NDKU_P" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_131" name="H01__NDKU_Vmax" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[NDKU_f],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[H01__UGP_Vmax],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[H01__NDKU_P],Reference=Value&gt;/&lt;CN=Root,Model=NoName,Vector=Values[REF_P],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_132" name="PGM1_f" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_133" name="PGM1_keq" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_134" name="PGM1_k_glc6p" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_135" name="PGM1_k_glc1p" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_136" name="H01__PGM1_P" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_137" name="H01__PGM1_Vmax" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[PGM1_f],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[H01__GALK_Vmax],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[H01__PGM1_P],Reference=Value&gt;/&lt;CN=Root,Model=NoName,Vector=Values[REF_P],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_138" name="GLY_f" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_139" name="GLY_k_glc6p" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_140" name="GLY_k_p" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_141" name="H01__GLY_P" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_142" name="H01__GLY_Vmax" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[GLY_f],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[H01__PGM1_Vmax],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[H01__GLY_P],Reference=Value&gt;/&lt;CN=Root,Model=NoName,Vector=Values[REF_P],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_143" name="GTF_f" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_144" name="GTF_k_udpgal" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_145" name="GTF_k_udpglc" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_146" name="H01__GTF_P" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_147" name="H01__GTF_Vmax" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[GTF_f],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[H01__GALK_Vmax],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[H01__GTF_P],Reference=Value&gt;/&lt;CN=Root,Model=NoName,Vector=Values[REF_P],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_148" name="GLUT2_f" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_149" name="GLUT2_k_gal" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_150" name="H01__GLUT2_P" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_151" name="H01__GLUT2_Vmax" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[GLUT2_f],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[scale],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[H01__GLUT2_P],Reference=Value&gt;/&lt;CN=Root,Model=NoName,Vector=Values[REF_P],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_152" name="H01__GLUT2_dm" simulationType="assignment">
        <Expression>
          1+(&lt;CN=Root,Model=NoName,Vector=Compartments[D001],Vector=Metabolites[gal],Reference=Concentration&gt;+&lt;CN=Root,Model=NoName,Vector=Compartments[D001],Vector=Metabolites[galM],Reference=Concentration&gt;)/&lt;CN=Root,Model=NoName,Vector=Values[GLUT2_k_gal],Reference=Value&gt;+(&lt;CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[D-galactose],Reference=Concentration&gt;+&lt;CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[D-galactose M],Reference=Concentration&gt;)/&lt;CN=Root,Model=NoName,Vector=Values[GLUT2_k_gal],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_153" name="H2OT_f" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_154" name="H2OT_k" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_155" name="H01__H2OT_Vmax" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[H2OT_f],Reference=Value&gt;*&lt;CN=Root,Model=NoName,Vector=Values[scale],Reference=Value&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_156" name="H01__H2OTM" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Reactions[H2O M transport],Reference=Flux&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_157" name="H01__GLUT2_GAL" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Reactions[galactose transport],Reference=Flux&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_158" name="H01__GLUT2_GALM" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Reactions[galactose transport_2],Reference=Flux&gt;
        </Expression>
      </ModelValue>
    </ListOfModelValues>
    <ListOfReactions>
      <Reaction key="Reaction_0" name="FlowPPS001_rbcM" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_0" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_1" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3112" name="A_sin" value="1"/>
          <Constant key="Parameter_3113" name="flow_sin" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_40">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_246">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_258">
              <SourceParameter reference="Metabolite_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_265">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_1" name="FlowS001PV_rbcM" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_1" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_3" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3114" name="A_sin" value="1"/>
          <Constant key="Parameter_3115" name="flow_sin" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_41">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Metabolite_1"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_271">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_2" name="FlowPVNULL_rbcM" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_3" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_3116" name="A_sin" value="1"/>
          <Constant key="Parameter_3117" name="flow_sin" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_42">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_276">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_277">
              <SourceParameter reference="Compartment_3"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_278">
              <SourceParameter reference="Metabolite_3"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_279">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_3" name="FlowPPS001_suc" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_4" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_5" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3118" name="A_sin" value="1"/>
          <Constant key="Parameter_3119" name="flow_sin" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_43">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_254">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_284">
              <SourceParameter reference="Metabolite_4"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_285">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_4" name="FlowS001PV_suc" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_5" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_7" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3120" name="A_sin" value="1"/>
          <Constant key="Parameter_3121" name="flow_sin" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_44">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_289">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_290">
              <SourceParameter reference="Metabolite_5"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_291">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_5" name="FlowPVNULL_suc" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_7" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_3122" name="A_sin" value="1"/>
          <Constant key="Parameter_3123" name="flow_sin" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_45">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_296">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_297">
              <SourceParameter reference="Compartment_3"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_298">
              <SourceParameter reference="Metabolite_7"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_299">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_6" name="FlowPPS001_alb" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_8" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_9" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3124" name="A_sin" value="1"/>
          <Constant key="Parameter_3125" name="flow_sin" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_46">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_275">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_304">
              <SourceParameter reference="Metabolite_8"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_305">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_7" name="FlowS001PV_alb" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_9" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_11" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3126" name="A_sin" value="1"/>
          <Constant key="Parameter_3127" name="flow_sin" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_47">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_309">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_310">
              <SourceParameter reference="Metabolite_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_311">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_8" name="FlowPVNULL_alb" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_11" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_3128" name="A_sin" value="1"/>
          <Constant key="Parameter_3129" name="flow_sin" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_48">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_316">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_317">
              <SourceParameter reference="Compartment_3"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_318">
              <SourceParameter reference="Metabolite_11"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_319">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_9" name="FlowPPS001_gal" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_12" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_13" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3130" name="A_sin" value="1"/>
          <Constant key="Parameter_3131" name="flow_sin" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_49">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_295">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_324">
              <SourceParameter reference="Metabolite_12"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_325">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_10" name="FlowS001PV_gal" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_13" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_15" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3132" name="A_sin" value="1"/>
          <Constant key="Parameter_3133" name="flow_sin" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_50">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_329">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_330">
              <SourceParameter reference="Metabolite_13"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_331">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_11" name="FlowPVNULL_gal" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_15" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_3134" name="A_sin" value="1"/>
          <Constant key="Parameter_3135" name="flow_sin" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_51">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_336">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_337">
              <SourceParameter reference="Compartment_3"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_338">
              <SourceParameter reference="Metabolite_15"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_339">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_12" name="FlowPPS001_galM" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_16" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_17" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3136" name="A_sin" value="1"/>
          <Constant key="Parameter_3137" name="flow_sin" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_52">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_315">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_344">
              <SourceParameter reference="Metabolite_16"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_345">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_13" name="FlowS001PV_galM" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_17" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_19" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3138" name="A_sin" value="1"/>
          <Constant key="Parameter_3141" name="flow_sin" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_53">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_349">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_350">
              <SourceParameter reference="Metabolite_17"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_351">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_14" name="FlowPVNULL_galM" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_19" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_3140" name="A_sin" value="1"/>
          <Constant key="Parameter_3142" name="flow_sin" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_54">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_356">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_357">
              <SourceParameter reference="Compartment_3"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_358">
              <SourceParameter reference="Metabolite_19"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_359">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_15" name="FlowPPS001_h2oM" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_20" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_21" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3139" name="A_sin" value="1"/>
          <Constant key="Parameter_3143" name="flow_sin" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_55">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_335">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_364">
              <SourceParameter reference="Metabolite_20"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_365">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_16" name="FlowS001PV_h2oM" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_21" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_23" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3144" name="A_sin" value="1"/>
          <Constant key="Parameter_3145" name="flow_sin" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_56">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_369">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_370">
              <SourceParameter reference="Metabolite_21"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_371">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_17" name="FlowPVNULL_h2oM" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_23" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_3146" name="A_sin" value="1"/>
          <Constant key="Parameter_3147" name="flow_sin" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_57">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_376">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_377">
              <SourceParameter reference="Compartment_3"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_378">
              <SourceParameter reference="Metabolite_23"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_379">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_18" name="DiffPPS001_rbcM" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_0" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_1" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3148" name="Dx_sin_rbcM" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_58">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_355">
              <SourceParameter reference="ModelValue_19"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_384">
              <SourceParameter reference="Metabolite_0"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_385">
              <SourceParameter reference="Metabolite_1"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_19" name="DiffS001PV_rbcM" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_1" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_3" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3149" name="Dx_sin_rbcM" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_59">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_389">
              <SourceParameter reference="ModelValue_19"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_390">
              <SourceParameter reference="Metabolite_3"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_391">
              <SourceParameter reference="Metabolite_1"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_20" name="DiffS001D001_rbcM" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_1" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_2" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3150" name="Dy_sindis_rbcM" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_60">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_395">
              <SourceParameter reference="Metabolite_2"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_396">
              <SourceParameter reference="ModelValue_21"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_397">
              <SourceParameter reference="Metabolite_1"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_21" name="DiffPPS001_suc" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_4" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_5" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3151" name="Dx_sin_suc" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_61">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_401">
              <SourceParameter reference="ModelValue_23"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_402">
              <SourceParameter reference="Metabolite_4"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_403">
              <SourceParameter reference="Metabolite_5"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_22" name="DiffS001PV_suc" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_5" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_7" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3152" name="Dx_sin_suc" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_62">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_407">
              <SourceParameter reference="ModelValue_23"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_408">
              <SourceParameter reference="Metabolite_7"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_409">
              <SourceParameter reference="Metabolite_5"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_23" name="DiffS001D001_suc" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_5" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_6" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3153" name="Dy_sindis_suc" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_63">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_413">
              <SourceParameter reference="Metabolite_6"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_414">
              <SourceParameter reference="ModelValue_25"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_415">
              <SourceParameter reference="Metabolite_5"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_24" name="DiffPPS001_alb" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_8" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_9" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3154" name="Dx_sin_alb" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_64">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_419">
              <SourceParameter reference="ModelValue_27"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_420">
              <SourceParameter reference="Metabolite_8"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_421">
              <SourceParameter reference="Metabolite_9"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_25" name="DiffS001PV_alb" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_9" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_11" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3155" name="Dx_sin_alb" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_65">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_425">
              <SourceParameter reference="ModelValue_27"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_426">
              <SourceParameter reference="Metabolite_11"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_427">
              <SourceParameter reference="Metabolite_9"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_26" name="DiffS001D001_alb" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_9" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_10" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3156" name="Dy_sindis_alb" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_66">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_431">
              <SourceParameter reference="Metabolite_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_432">
              <SourceParameter reference="ModelValue_29"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_433">
              <SourceParameter reference="Metabolite_9"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_27" name="DiffPPS001_gal" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_12" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_13" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3157" name="Dx_sin_gal" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_67">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_437">
              <SourceParameter reference="ModelValue_31"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_438">
              <SourceParameter reference="Metabolite_12"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_439">
              <SourceParameter reference="Metabolite_13"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_28" name="DiffS001PV_gal" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_13" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_15" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3158" name="Dx_sin_gal" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_68">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_443">
              <SourceParameter reference="ModelValue_31"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_444">
              <SourceParameter reference="Metabolite_15"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_445">
              <SourceParameter reference="Metabolite_13"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_29" name="DiffS001D001_gal" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_13" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_14" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3163" name="Dy_sindis_gal" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_69">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_449">
              <SourceParameter reference="Metabolite_14"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_450">
              <SourceParameter reference="ModelValue_33"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_451">
              <SourceParameter reference="Metabolite_13"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_30" name="DiffPPS001_galM" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_16" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_17" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3162" name="Dx_sin_galM" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_70">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_455">
              <SourceParameter reference="ModelValue_35"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_456">
              <SourceParameter reference="Metabolite_16"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_457">
              <SourceParameter reference="Metabolite_17"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_31" name="DiffS001PV_galM" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_17" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_19" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3161" name="Dx_sin_galM" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_71">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_461">
              <SourceParameter reference="ModelValue_35"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_462">
              <SourceParameter reference="Metabolite_19"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_463">
              <SourceParameter reference="Metabolite_17"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_32" name="DiffS001D001_galM" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_17" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_18" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3159" name="Dy_sindis_galM" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_72">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_467">
              <SourceParameter reference="Metabolite_18"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_468">
              <SourceParameter reference="ModelValue_37"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_469">
              <SourceParameter reference="Metabolite_17"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_33" name="DiffPPS001_h2oM" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_20" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_21" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3160" name="Dx_sin_h2oM" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_73">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_473">
              <SourceParameter reference="ModelValue_39"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_474">
              <SourceParameter reference="Metabolite_20"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_475">
              <SourceParameter reference="Metabolite_21"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_34" name="DiffS001PV_h2oM" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_21" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_23" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3164" name="Dx_sin_h2oM" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_74">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_479">
              <SourceParameter reference="ModelValue_39"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_480">
              <SourceParameter reference="Metabolite_23"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_481">
              <SourceParameter reference="Metabolite_21"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_35" name="DiffS001D001_h2oM" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_21" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_22" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3165" name="Dy_sindis_h2oM" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_75">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_485">
              <SourceParameter reference="Metabolite_22"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_486">
              <SourceParameter reference="ModelValue_41"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_487">
              <SourceParameter reference="Metabolite_21"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_36" name="Galactokinase (H01)" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_24" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_33" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_29" stoichiometry="1"/>
          <Product metabolite="Metabolite_34" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3168" name="GALK_k_atp" value="1"/>
          <Constant key="Parameter_3167" name="GALK_k_gal" value="1"/>
          <Constant key="Parameter_3166" name="GALK_keq" value="1"/>
          <Constant key="Parameter_3169" name="GALK_ki_gal1p" value="1"/>
          <Constant key="Parameter_3170" name="H01__GALK_Vmax" value="1"/>
          <Constant key="Parameter_3171" name="H01__GALK_dm" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_76">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_499">
              <SourceParameter reference="ModelValue_57"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_500">
              <SourceParameter reference="ModelValue_56"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_501">
              <SourceParameter reference="ModelValue_51"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_502">
              <SourceParameter reference="ModelValue_54"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_503">
              <SourceParameter reference="Compartment_4"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_504">
              <SourceParameter reference="ModelValue_59"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_505">
              <SourceParameter reference="ModelValue_60"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_506">
              <SourceParameter reference="Metabolite_34"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_507">
              <SourceParameter reference="Metabolite_33"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_508">
              <SourceParameter reference="Metabolite_24"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_509">
              <SourceParameter reference="Metabolite_29"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_37" name="Galactokinase (H01)_2" reversible="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_25" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_33" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_29" stoichiometry="1"/>
          <Product metabolite="Metabolite_34" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3172" name="GALK_k_atp" value="1"/>
          <Constant key="Parameter_3173" name="GALK_k_gal" value="1"/>
          <Constant key="Parameter_3174" name="GALK_ki_gal1p" value="1"/>
          <Constant key="Parameter_3175" name="H01__GALK_Vmax" value="1"/>
          <Constant key="Parameter_3176" name="H01__GALK_dm" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_77">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_262">
              <SourceParameter reference="ModelValue_57"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_375">
              <SourceParameter reference="ModelValue_56"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_521">
              <SourceParameter reference="ModelValue_54"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_522">
              <SourceParameter reference="Compartment_4"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_523">
              <SourceParameter reference="ModelValue_59"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_524">
              <SourceParameter reference="ModelValue_60"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_525">
              <SourceParameter reference="Metabolite_33"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_526">
              <SourceParameter reference="Metabolite_29"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_527">
              <SourceParameter reference="Metabolite_25"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_38" name="Inositol monophosphatase (H01)" reversible="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_29" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_24" stoichiometry="1"/>
          <Product metabolite="Metabolite_37" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3177" name="H01__IMP_Vmax" value="1"/>
          <Constant key="Parameter_3178" name="IMP_k_gal1p" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_78">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_491">
              <SourceParameter reference="Compartment_4"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_496">
              <SourceParameter reference="ModelValue_64"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_497">
              <SourceParameter reference="Metabolite_29"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_493">
              <SourceParameter reference="ModelValue_62"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_39" name="ATP synthase (H01)" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_34" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_37" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_33" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3179" name="ATPS_k_adp" value="1"/>
          <Constant key="Parameter_3180" name="ATPS_k_atp" value="1"/>
          <Constant key="Parameter_3181" name="ATPS_k_phos" value="1"/>
          <Constant key="Parameter_3182" name="ATPS_keq" value="1"/>
          <Constant key="Parameter_3183" name="H01__ATPS_Vmax" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_79">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_545">
              <SourceParameter reference="ModelValue_67"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_546">
              <SourceParameter reference="ModelValue_68"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_547">
              <SourceParameter reference="ModelValue_69"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_548">
              <SourceParameter reference="ModelValue_66"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_549">
              <SourceParameter reference="Compartment_4"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_550">
              <SourceParameter reference="ModelValue_71"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_551">
              <SourceParameter reference="Metabolite_34"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_552">
              <SourceParameter reference="Metabolite_33"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_553">
              <SourceParameter reference="Metabolite_37"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_40" name="Aldose reductase (H01)" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_24" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_40" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_32" stoichiometry="1"/>
          <Product metabolite="Metabolite_39" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3184" name="ALDR_k_gal" value="1"/>
          <Constant key="Parameter_3185" name="ALDR_k_galtol" value="1"/>
          <Constant key="Parameter_3186" name="ALDR_k_nadp" value="1"/>
          <Constant key="Parameter_3187" name="ALDR_k_nadph" value="1"/>
          <Constant key="Parameter_3188" name="ALDR_keq" value="1"/>
          <Constant key="Parameter_3189" name="H01__ALDR_Vmax" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_80">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_565">
              <SourceParameter reference="ModelValue_74"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_566">
              <SourceParameter reference="ModelValue_75"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_567">
              <SourceParameter reference="ModelValue_76"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_568">
              <SourceParameter reference="ModelValue_77"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_569">
              <SourceParameter reference="ModelValue_73"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_570">
              <SourceParameter reference="Compartment_4"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_571">
              <SourceParameter reference="ModelValue_79"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_572">
              <SourceParameter reference="Metabolite_24"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_573">
              <SourceParameter reference="Metabolite_32"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_574">
              <SourceParameter reference="Metabolite_39"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_575">
              <SourceParameter reference="Metabolite_40"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_41" name="NADP Reductase (H01)" reversible="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_39" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_40" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3190" name="H01__NADPR_Vmax" value="1"/>
          <Constant key="Parameter_3191" name="NADPR_k_nadp" value="1"/>
          <Constant key="Parameter_3192" name="NADPR_keq" value="1"/>
          <Constant key="Parameter_3193" name="NADPR_ki_nadph" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_81">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_498">
              <SourceParameter reference="Compartment_4"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_492">
              <SourceParameter reference="ModelValue_85"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_563">
              <SourceParameter reference="Metabolite_39"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_541">
              <SourceParameter reference="Metabolite_40"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_587">
              <SourceParameter reference="ModelValue_82"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_588">
              <SourceParameter reference="ModelValue_81"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_589">
              <SourceParameter reference="ModelValue_83"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_42" name="Galactose-1-phosphate uridyl transferase (H01)" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_29" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_30" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_27" stoichiometry="1"/>
          <Product metabolite="Metabolite_31" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_36" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_35" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_3194" name="GALT_k_gal1p" value="1"/>
          <Constant key="Parameter_3195" name="GALT_k_glc1p" value="1"/>
          <Constant key="Parameter_3196" name="GALT_k_udpgal" value="1"/>
          <Constant key="Parameter_3197" name="GALT_k_udpglc" value="1"/>
          <Constant key="Parameter_3198" name="GALT_keq" value="1"/>
          <Constant key="Parameter_3101" name="GALT_ki_udp" value="1"/>
          <Constant key="Parameter_3102" name="GALT_ki_utp" value="1"/>
          <Constant key="Parameter_3103" name="H01__GALT_Vmax" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_82">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_605">
              <SourceParameter reference="ModelValue_93"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_606">
              <SourceParameter reference="ModelValue_88"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_607">
              <SourceParameter reference="ModelValue_89"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_608">
              <SourceParameter reference="ModelValue_94"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_609">
              <SourceParameter reference="ModelValue_87"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_610">
              <SourceParameter reference="ModelValue_91"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_611">
              <SourceParameter reference="ModelValue_90"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_612">
              <SourceParameter reference="Compartment_4"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_613">
              <SourceParameter reference="ModelValue_96"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_614">
              <SourceParameter reference="Metabolite_29"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_615">
              <SourceParameter reference="Metabolite_27"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_616">
              <SourceParameter reference="Metabolite_36"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_617">
              <SourceParameter reference="Metabolite_31"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_618">
              <SourceParameter reference="Metabolite_30"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_619">
              <SourceParameter reference="Metabolite_35"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_43" name="UDP-glucose 4-epimerase (H01)" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_30" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_31" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3104" name="GALE_k_udpgal" value="1"/>
          <Constant key="Parameter_3105" name="GALE_k_udpglc" value="1"/>
          <Constant key="Parameter_3106" name="GALE_keq" value="1"/>
          <Constant key="Parameter_3107" name="H01__GALE_Vmax" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_83">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_604">
              <SourceParameter reference="ModelValue_102"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_601">
              <SourceParameter reference="ModelValue_101"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_599">
              <SourceParameter reference="ModelValue_100"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_597">
              <SourceParameter reference="Compartment_4"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_264">
              <SourceParameter reference="ModelValue_104"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_603">
              <SourceParameter reference="Metabolite_31"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_602">
              <SourceParameter reference="Metabolite_30"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_44" name="UDP-glucose pyrophosphorylase (H01)" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_27" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_35" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_30" stoichiometry="1"/>
          <Product metabolite="Metabolite_38" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3108" name="H01__UGP_Vmax" value="1"/>
          <Constant key="Parameter_3109" name="H01__UGP_dm" value="1"/>
          <Constant key="Parameter_3110" name="UGP_k_glc1p" value="1"/>
          <Constant key="Parameter_3199" name="UGP_k_utp" value="1"/>
          <Constant key="Parameter_3200" name="UGP_keq" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_84">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_644">
              <SourceParameter reference="Compartment_4"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_645">
              <SourceParameter reference="ModelValue_117"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_646">
              <SourceParameter reference="ModelValue_118"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_647">
              <SourceParameter reference="Metabolite_27"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_648">
              <SourceParameter reference="Metabolite_38"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_649">
              <SourceParameter reference="Metabolite_30"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_650">
              <SourceParameter reference="Metabolite_35"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_651">
              <SourceParameter reference="ModelValue_109"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_652">
              <SourceParameter reference="ModelValue_108"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_653">
              <SourceParameter reference="ModelValue_107"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_45" name="UDP-galactose pyrophosphorylase (H01)" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_29" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_35" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_31" stoichiometry="1"/>
          <Product metabolite="Metabolite_38" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_3000" name="H01__UGP_Vmax" value="1"/>
          <Constant key="Parameter_2999" name="H01__UGP_dm" value="1"/>
          <Constant key="Parameter_2998" name="UGALP_f" value="1"/>
          <Constant key="Parameter_2997" name="UGP_k_gal1p" value="1"/>
          <Constant key="Parameter_2996" name="UGP_k_utp" value="1"/>
          <Constant key="Parameter_2995" name="UGP_keq" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_85">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_665">
              <SourceParameter reference="Compartment_4"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_666">
              <SourceParameter reference="ModelValue_117"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_667">
              <SourceParameter reference="ModelValue_118"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_668">
              <SourceParameter reference="Metabolite_29"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_669">
              <SourceParameter reference="Metabolite_38"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_670">
              <SourceParameter reference="Metabolite_31"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_671">
              <SourceParameter reference="Metabolite_35"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_672">
              <SourceParameter reference="ModelValue_106"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_673">
              <SourceParameter reference="ModelValue_112"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_674">
              <SourceParameter reference="ModelValue_108"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_675">
              <SourceParameter reference="ModelValue_107"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_46" name="Pyrophosphatase (H01)" reversible="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_38" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_37" stoichiometry="2"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_2994" name="H01__PPASE_Vmax" value="1"/>
          <Constant key="Parameter_2993" name="PPASE_k_ppi" value="1"/>
          <Constant key="Parameter_2992" name="PPASE_n" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_86">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_564">
              <SourceParameter reference="Compartment_4"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_642">
              <SourceParameter reference="ModelValue_123"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_542">
              <SourceParameter reference="Metabolite_38"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_643">
              <SourceParameter reference="ModelValue_120"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_598">
              <SourceParameter reference="ModelValue_121"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_47" name="ATP:UDP phosphotransferase (H01)" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_33" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_36" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_34" stoichiometry="1"/>
          <Product metabolite="Metabolite_35" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_2991" name="H01__NDKU_Vmax" value="1"/>
          <Constant key="Parameter_2990" name="NDKU_k_adp" value="1"/>
          <Constant key="Parameter_2989" name="NDKU_k_atp" value="1"/>
          <Constant key="Parameter_2988" name="NDKU_k_udp" value="1"/>
          <Constant key="Parameter_2987" name="NDKU_k_utp" value="1"/>
          <Constant key="Parameter_2986" name="NDKU_keq" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_87">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_697">
              <SourceParameter reference="Compartment_4"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_698">
              <SourceParameter reference="ModelValue_131"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_699">
              <SourceParameter reference="Metabolite_34"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_700">
              <SourceParameter reference="Metabolite_33"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_701">
              <SourceParameter reference="Metabolite_36"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_702">
              <SourceParameter reference="Metabolite_35"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_703">
              <SourceParameter reference="ModelValue_127"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_704">
              <SourceParameter reference="ModelValue_126"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_705">
              <SourceParameter reference="ModelValue_129"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_706">
              <SourceParameter reference="ModelValue_128"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_707">
              <SourceParameter reference="ModelValue_125"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_48" name="Phosphoglucomutase-1 (H01)" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_27" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_28" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_2985" name="H01__PGM1_Vmax" value="1"/>
          <Constant key="Parameter_2984" name="PGM1_k_glc1p" value="1"/>
          <Constant key="Parameter_2983" name="PGM1_k_glc6p" value="1"/>
          <Constant key="Parameter_2982" name="PGM1_keq" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_88">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_543">
              <SourceParameter reference="Compartment_4"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_691">
              <SourceParameter reference="ModelValue_137"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_544">
              <SourceParameter reference="Metabolite_27"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_696">
              <SourceParameter reference="Metabolite_28"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_719">
              <SourceParameter reference="ModelValue_135"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_720">
              <SourceParameter reference="ModelValue_134"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_721">
              <SourceParameter reference="ModelValue_133"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_49" name="Glycolysis (H01)" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_28" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_37" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_2981" name="GLY_k_glc6p" value="1"/>
          <Constant key="Parameter_2980" name="GLY_k_p" value="1"/>
          <Constant key="Parameter_2979" name="H01__GLY_Vmax" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_89">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_495">
              <SourceParameter reference="ModelValue_139"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_729">
              <SourceParameter reference="ModelValue_140"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_730">
              <SourceParameter reference="Compartment_4"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_731">
              <SourceParameter reference="ModelValue_142"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_732">
              <SourceParameter reference="Metabolite_28"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_733">
              <SourceParameter reference="Metabolite_37"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_50" name="Glycosyltransferase galactose (H01)" reversible="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_31" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_36" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_2978" name="GTF_k_udpgal" value="1"/>
          <Constant key="Parameter_2977" name="H01__GTF_Vmax" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_90">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_600">
              <SourceParameter reference="ModelValue_144"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_695">
              <SourceParameter reference="Compartment_4"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_740">
              <SourceParameter reference="ModelValue_147"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_741">
              <SourceParameter reference="Metabolite_31"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_51" name="Glycosyltransferase glucose (H01)" reversible="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_30" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_36" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_2976" name="GTF_k_udpglc" value="1"/>
          <Constant key="Parameter_2975" name="H01__GTF_Vmax" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_91">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_746">
              <SourceParameter reference="ModelValue_145"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_747">
              <SourceParameter reference="Compartment_4"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_748">
              <SourceParameter reference="ModelValue_147"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_749">
              <SourceParameter reference="Metabolite_30"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_52" name="galactose transport" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_14" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_24" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_2974" name="GLUT2_k_gal" value="1"/>
          <Constant key="Parameter_2973" name="H01__GLUT2_Vmax" value="1"/>
          <Constant key="Parameter_2972" name="H01__GLUT2_dm" value="1"/>
          <Constant key="Parameter_2971" name="Nf" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_92">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_756">
              <SourceParameter reference="Metabolite_14"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_757">
              <SourceParameter reference="ModelValue_149"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_758">
              <SourceParameter reference="ModelValue_151"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_759">
              <SourceParameter reference="ModelValue_152"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_760">
              <SourceParameter reference="Metabolite_24"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_761">
              <SourceParameter reference="ModelValue_6"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_53" name="galactose transport_2" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_18" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_25" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_2970" name="GLUT2_k_gal" value="1"/>
          <Constant key="Parameter_2969" name="H01__GLUT2_Vmax" value="1"/>
          <Constant key="Parameter_2968" name="H01__GLUT2_dm" value="1"/>
          <Constant key="Parameter_2967" name="Nf" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_93">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_768">
              <SourceParameter reference="Metabolite_18"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_769">
              <SourceParameter reference="ModelValue_149"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_770">
              <SourceParameter reference="ModelValue_151"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_771">
              <SourceParameter reference="ModelValue_152"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_772">
              <SourceParameter reference="Metabolite_25"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_773">
              <SourceParameter reference="ModelValue_6"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_54" name="H2O M transport" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_22" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_26" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_2966" name="H01__H2OT_Vmax" value="1"/>
          <Constant key="Parameter_2965" name="H2OT_k" value="1"/>
          <Constant key="Parameter_2964" name="Nf" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_94">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_641">
              <SourceParameter reference="Metabolite_22"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_780">
              <SourceParameter reference="ModelValue_155"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_781">
              <SourceParameter reference="Metabolite_26"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_782">
              <SourceParameter reference="ModelValue_154"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_783">
              <SourceParameter reference="ModelValue_6"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
    </ListOfReactions>
    <ListOfEvents>
      <Event key="Event_0" name="EDEF_00" fireAtInitialTime="0" persistentTrigger="0">
        <TriggerExpression>
          &lt;CN=Root,Model=NoName,Reference=Time&gt; gt 0 and &lt;CN=Root,Model=NoName,Vector=Values[deficiency],Reference=Value&gt; eq 0
        </TriggerExpression>
        <ListOfAssignments>
          <Assignment targetKey="ModelValue_55">
            <Expression>
              8.7
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_56">
            <Expression>
              0.97
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_57">
            <Expression>
              0.034
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_92">
            <Expression>
              804
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_93">
            <Expression>
              1.25
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_94">
            <Expression>
              0.95
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_99">
            <Expression>
              36
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_101">
            <Expression>
              0.069
            </Expression>
          </Assignment>
        </ListOfAssignments>
      </Event>
      <Event key="Event_1" name="EDEF_01" fireAtInitialTime="0" persistentTrigger="0">
        <TriggerExpression>
          &lt;CN=Root,Model=NoName,Reference=Time&gt; gt 0 and &lt;CN=Root,Model=NoName,Vector=Values[deficiency],Reference=Value&gt; eq 1
        </TriggerExpression>
        <ListOfAssignments>
          <Assignment targetKey="ModelValue_55">
            <Expression>
              2
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_56">
            <Expression>
              7.7
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_57">
            <Expression>
              0.13
            </Expression>
          </Assignment>
        </ListOfAssignments>
      </Event>
      <Event key="Event_2" name="EDEF_02" fireAtInitialTime="0" persistentTrigger="0">
        <TriggerExpression>
          &lt;CN=Root,Model=NoName,Reference=Time&gt; gt 0 and &lt;CN=Root,Model=NoName,Vector=Values[deficiency],Reference=Value&gt; eq 2
        </TriggerExpression>
        <ListOfAssignments>
          <Assignment targetKey="ModelValue_55">
            <Expression>
              3.9
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_56">
            <Expression>
              0.43
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_57">
            <Expression>
              0.11
            </Expression>
          </Assignment>
        </ListOfAssignments>
      </Event>
      <Event key="Event_3" name="EDEF_03" fireAtInitialTime="0" persistentTrigger="0">
        <TriggerExpression>
          &lt;CN=Root,Model=NoName,Reference=Time&gt; gt 0 and &lt;CN=Root,Model=NoName,Vector=Values[deficiency],Reference=Value&gt; eq 3
        </TriggerExpression>
        <ListOfAssignments>
          <Assignment targetKey="ModelValue_55">
            <Expression>
              5.9
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_56">
            <Expression>
              0.66
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_57">
            <Expression>
              0.026
            </Expression>
          </Assignment>
        </ListOfAssignments>
      </Event>
      <Event key="Event_4" name="EDEF_04" fireAtInitialTime="0" persistentTrigger="0">
        <TriggerExpression>
          &lt;CN=Root,Model=NoName,Reference=Time&gt; gt 0 and &lt;CN=Root,Model=NoName,Vector=Values[deficiency],Reference=Value&gt; eq 4
        </TriggerExpression>
        <ListOfAssignments>
          <Assignment targetKey="ModelValue_55">
            <Expression>
              0.4
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_56">
            <Expression>
              1.1
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_57">
            <Expression>
              0.005
            </Expression>
          </Assignment>
        </ListOfAssignments>
      </Event>
      <Event key="Event_5" name="EDEF_05" fireAtInitialTime="0" persistentTrigger="0">
        <TriggerExpression>
          &lt;CN=Root,Model=NoName,Reference=Time&gt; gt 0 and &lt;CN=Root,Model=NoName,Vector=Values[deficiency],Reference=Value&gt; eq 5
        </TriggerExpression>
        <ListOfAssignments>
          <Assignment targetKey="ModelValue_55">
            <Expression>
              1.1
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_56">
            <Expression>
              13
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_57">
            <Expression>
              0.089
            </Expression>
          </Assignment>
        </ListOfAssignments>
      </Event>
      <Event key="Event_6" name="EDEF_06" fireAtInitialTime="0" persistentTrigger="0">
        <TriggerExpression>
          &lt;CN=Root,Model=NoName,Reference=Time&gt; gt 0 and &lt;CN=Root,Model=NoName,Vector=Values[deficiency],Reference=Value&gt; eq 6
        </TriggerExpression>
        <ListOfAssignments>
          <Assignment targetKey="ModelValue_55">
            <Expression>
              1.8
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_56">
            <Expression>
              1.7
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_57">
            <Expression>
              0.039
            </Expression>
          </Assignment>
        </ListOfAssignments>
      </Event>
      <Event key="Event_7" name="EDEF_07" fireAtInitialTime="0" persistentTrigger="0">
        <TriggerExpression>
          &lt;CN=Root,Model=NoName,Reference=Time&gt; gt 0 and &lt;CN=Root,Model=NoName,Vector=Values[deficiency],Reference=Value&gt; eq 7
        </TriggerExpression>
        <ListOfAssignments>
          <Assignment targetKey="ModelValue_55">
            <Expression>
              6.7
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_56">
            <Expression>
              1.9
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_57">
            <Expression>
              0.035
            </Expression>
          </Assignment>
        </ListOfAssignments>
      </Event>
      <Event key="Event_8" name="EDEF_08" fireAtInitialTime="0" persistentTrigger="0">
        <TriggerExpression>
          &lt;CN=Root,Model=NoName,Reference=Time&gt; gt 0 and &lt;CN=Root,Model=NoName,Vector=Values[deficiency],Reference=Value&gt; eq 8
        </TriggerExpression>
        <ListOfAssignments>
          <Assignment targetKey="ModelValue_55">
            <Expression>
              0.9
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_56">
            <Expression>
              0.14
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_57">
            <Expression>
              0.0039
            </Expression>
          </Assignment>
        </ListOfAssignments>
      </Event>
      <Event key="Event_9" name="EDEF_09" fireAtInitialTime="0" persistentTrigger="0">
        <TriggerExpression>
          &lt;CN=Root,Model=NoName,Reference=Time&gt; gt 0 and &lt;CN=Root,Model=NoName,Vector=Values[deficiency],Reference=Value&gt; eq 9
        </TriggerExpression>
        <ListOfAssignments>
          <Assignment targetKey="ModelValue_92">
            <Expression>
              396
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_93">
            <Expression>
              1.89
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_94">
            <Expression>
              0.58
            </Expression>
          </Assignment>
        </ListOfAssignments>
      </Event>
      <Event key="Event_10" name="EDEF_10" fireAtInitialTime="0" persistentTrigger="0">
        <TriggerExpression>
          &lt;CN=Root,Model=NoName,Reference=Time&gt; gt 0 and &lt;CN=Root,Model=NoName,Vector=Values[deficiency],Reference=Value&gt; eq 10
        </TriggerExpression>
        <ListOfAssignments>
          <Assignment targetKey="ModelValue_92">
            <Expression>
              253
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_93">
            <Expression>
              2.34
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_94">
            <Expression>
              0.69
            </Expression>
          </Assignment>
        </ListOfAssignments>
      </Event>
      <Event key="Event_11" name="EDEF_11" fireAtInitialTime="0" persistentTrigger="0">
        <TriggerExpression>
          &lt;CN=Root,Model=NoName,Reference=Time&gt; gt 0 and &lt;CN=Root,Model=NoName,Vector=Values[deficiency],Reference=Value&gt; eq 11
        </TriggerExpression>
        <ListOfAssignments>
          <Assignment targetKey="ModelValue_92">
            <Expression>
              297
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_93">
            <Expression>
              1.12
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_94">
            <Expression>
              0.76
            </Expression>
          </Assignment>
        </ListOfAssignments>
      </Event>
      <Event key="Event_12" name="EDEF_12" fireAtInitialTime="0" persistentTrigger="0">
        <TriggerExpression>
          &lt;CN=Root,Model=NoName,Reference=Time&gt; gt 0 and &lt;CN=Root,Model=NoName,Vector=Values[deficiency],Reference=Value&gt; eq 12
        </TriggerExpression>
        <ListOfAssignments>
          <Assignment targetKey="ModelValue_92">
            <Expression>
              45
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_93">
            <Expression>
              1.98
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_94">
            <Expression>
              1.23
            </Expression>
          </Assignment>
        </ListOfAssignments>
      </Event>
      <Event key="Event_13" name="EDEF_13" fireAtInitialTime="0" persistentTrigger="0">
        <TriggerExpression>
          &lt;CN=Root,Model=NoName,Reference=Time&gt; gt 0 and &lt;CN=Root,Model=NoName,Vector=Values[deficiency],Reference=Value&gt; eq 13
        </TriggerExpression>
        <ListOfAssignments>
          <Assignment targetKey="ModelValue_92">
            <Expression>
              306
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_93">
            <Expression>
              2.14
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_94">
            <Expression>
              0.48
            </Expression>
          </Assignment>
        </ListOfAssignments>
      </Event>
      <Event key="Event_14" name="EDEF_14" fireAtInitialTime="0" persistentTrigger="0">
        <TriggerExpression>
          &lt;CN=Root,Model=NoName,Reference=Time&gt; gt 0 and &lt;CN=Root,Model=NoName,Vector=Values[deficiency],Reference=Value&gt; eq 14
        </TriggerExpression>
        <ListOfAssignments>
          <Assignment targetKey="ModelValue_92">
            <Expression>
              385
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_93">
            <Expression>
              2.68
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_94">
            <Expression>
              0.95
            </Expression>
          </Assignment>
        </ListOfAssignments>
      </Event>
      <Event key="Event_15" name="EDEF_15" fireAtInitialTime="0" persistentTrigger="0">
        <TriggerExpression>
          &lt;CN=Root,Model=NoName,Reference=Time&gt; gt 0 and &lt;CN=Root,Model=NoName,Vector=Values[deficiency],Reference=Value&gt; eq 15
        </TriggerExpression>
        <ListOfAssignments>
          <Assignment targetKey="ModelValue_99">
            <Expression>
              32
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_101">
            <Expression>
              0.082
            </Expression>
          </Assignment>
        </ListOfAssignments>
      </Event>
      <Event key="Event_16" name="EDEF_16" fireAtInitialTime="0" persistentTrigger="0">
        <TriggerExpression>
          &lt;CN=Root,Model=NoName,Reference=Time&gt; gt 0 and &lt;CN=Root,Model=NoName,Vector=Values[deficiency],Reference=Value&gt; eq 16
        </TriggerExpression>
        <ListOfAssignments>
          <Assignment targetKey="ModelValue_99">
            <Expression>
              0.046
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_101">
            <Expression>
              0.093
            </Expression>
          </Assignment>
        </ListOfAssignments>
      </Event>
      <Event key="Event_17" name="EDEF_17" fireAtInitialTime="0" persistentTrigger="0">
        <TriggerExpression>
          &lt;CN=Root,Model=NoName,Reference=Time&gt; gt 0 and &lt;CN=Root,Model=NoName,Vector=Values[deficiency],Reference=Value&gt; eq 17
        </TriggerExpression>
        <ListOfAssignments>
          <Assignment targetKey="ModelValue_99">
            <Expression>
              1.1
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_101">
            <Expression>
              0.16
            </Expression>
          </Assignment>
        </ListOfAssignments>
      </Event>
      <Event key="Event_18" name="EDEF_18" fireAtInitialTime="0" persistentTrigger="0">
        <TriggerExpression>
          &lt;CN=Root,Model=NoName,Reference=Time&gt; gt 0 and &lt;CN=Root,Model=NoName,Vector=Values[deficiency],Reference=Value&gt; eq 18
        </TriggerExpression>
        <ListOfAssignments>
          <Assignment targetKey="ModelValue_99">
            <Expression>
              5
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_101">
            <Expression>
              0.14
            </Expression>
          </Assignment>
        </ListOfAssignments>
      </Event>
      <Event key="Event_19" name="EDEF_19" fireAtInitialTime="0" persistentTrigger="0">
        <TriggerExpression>
          &lt;CN=Root,Model=NoName,Reference=Time&gt; gt 0 and &lt;CN=Root,Model=NoName,Vector=Values[deficiency],Reference=Value&gt; eq 19
        </TriggerExpression>
        <ListOfAssignments>
          <Assignment targetKey="ModelValue_99">
            <Expression>
              11
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_101">
            <Expression>
              0.097
            </Expression>
          </Assignment>
        </ListOfAssignments>
      </Event>
      <Event key="Event_20" name="EDEF_20" fireAtInitialTime="0" persistentTrigger="0">
        <TriggerExpression>
          &lt;CN=Root,Model=NoName,Reference=Time&gt; gt 0 and &lt;CN=Root,Model=NoName,Vector=Values[deficiency],Reference=Value&gt; eq 20
        </TriggerExpression>
        <ListOfAssignments>
          <Assignment targetKey="ModelValue_99">
            <Expression>
              5.1
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_101">
            <Expression>
              0.066
            </Expression>
          </Assignment>
        </ListOfAssignments>
      </Event>
      <Event key="Event_21" name="EDEF_21" fireAtInitialTime="0" persistentTrigger="0">
        <TriggerExpression>
          &lt;CN=Root,Model=NoName,Reference=Time&gt; gt 0 and &lt;CN=Root,Model=NoName,Vector=Values[deficiency],Reference=Value&gt; eq 21
        </TriggerExpression>
        <ListOfAssignments>
          <Assignment targetKey="ModelValue_99">
            <Expression>
              5.8
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_101">
            <Expression>
              0.035
            </Expression>
          </Assignment>
        </ListOfAssignments>
      </Event>
      <Event key="Event_22" name="EDEF_22" fireAtInitialTime="0" persistentTrigger="0">
        <TriggerExpression>
          &lt;CN=Root,Model=NoName,Reference=Time&gt; gt 0 and &lt;CN=Root,Model=NoName,Vector=Values[deficiency],Reference=Value&gt; eq 22
        </TriggerExpression>
        <ListOfAssignments>
          <Assignment targetKey="ModelValue_99">
            <Expression>
              30
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_101">
            <Expression>
              0.078
            </Expression>
          </Assignment>
        </ListOfAssignments>
      </Event>
      <Event key="Event_23" name="EDEF_23" fireAtInitialTime="0" persistentTrigger="0">
        <TriggerExpression>
          &lt;CN=Root,Model=NoName,Reference=Time&gt; gt 0 and &lt;CN=Root,Model=NoName,Vector=Values[deficiency],Reference=Value&gt; eq 23
        </TriggerExpression>
        <ListOfAssignments>
          <Assignment targetKey="ModelValue_99">
            <Expression>
              15
            </Expression>
          </Assignment>
          <Assignment targetKey="ModelValue_101">
            <Expression>
              0.099
            </Expression>
          </Assignment>
        </ListOfAssignments>
      </Event>
      <Event key="Event_24" name="EDIL_1" fireAtInitialTime="0" persistentTrigger="0">
        <TriggerExpression>
          &lt;CN=Root,Model=NoName,Reference=Time&gt; eq 20
        </TriggerExpression>
        <ListOfAssignments>
          <Assignment targetKey="Metabolite_12">
            <Expression>
              1
            </Expression>
          </Assignment>
          <Assignment targetKey="Metabolite_0">
            <Expression>
              1
            </Expression>
          </Assignment>
          <Assignment targetKey="Metabolite_8">
            <Expression>
              1
            </Expression>
          </Assignment>
          <Assignment targetKey="Metabolite_20">
            <Expression>
              1
            </Expression>
          </Assignment>
          <Assignment targetKey="Metabolite_4">
            <Expression>
              1
            </Expression>
          </Assignment>
        </ListOfAssignments>
      </Event>
      <Event key="Event_25" name="EDIL_2" fireAtInitialTime="0" persistentTrigger="0">
        <TriggerExpression>
          &lt;CN=Root,Model=NoName,Reference=Time&gt; eq 25
        </TriggerExpression>
        <ListOfAssignments>
          <Assignment targetKey="Metabolite_12">
            <Expression>
              0.00012
            </Expression>
          </Assignment>
          <Assignment targetKey="Metabolite_0">
            <Expression>
              0
            </Expression>
          </Assignment>
          <Assignment targetKey="Metabolite_8">
            <Expression>
              0
            </Expression>
          </Assignment>
          <Assignment targetKey="Metabolite_20">
            <Expression>
              0
            </Expression>
          </Assignment>
          <Assignment targetKey="Metabolite_4">
            <Expression>
              0
            </Expression>
          </Assignment>
        </ListOfAssignments>
      </Event>
    </ListOfEvents>
    <StateTemplate>
      <StateTemplateVariable objectReference="Model_0"/>
      <StateTemplateVariable objectReference="Metabolite_37"/>
      <StateTemplateVariable objectReference="Metabolite_5"/>
      <StateTemplateVariable objectReference="Metabolite_9"/>
      <StateTemplateVariable objectReference="Metabolite_13"/>
      <StateTemplateVariable objectReference="Metabolite_17"/>
      <StateTemplateVariable objectReference="Metabolite_21"/>
      <StateTemplateVariable objectReference="Metabolite_1"/>
      <StateTemplateVariable objectReference="Metabolite_29"/>
      <StateTemplateVariable objectReference="Metabolite_30"/>
      <StateTemplateVariable objectReference="Metabolite_24"/>
      <StateTemplateVariable objectReference="Metabolite_33"/>
      <StateTemplateVariable objectReference="Metabolite_36"/>
      <StateTemplateVariable objectReference="Metabolite_3"/>
      <StateTemplateVariable objectReference="Metabolite_7"/>
      <StateTemplateVariable objectReference="Metabolite_11"/>
      <StateTemplateVariable objectReference="Metabolite_15"/>
      <StateTemplateVariable objectReference="Metabolite_19"/>
      <StateTemplateVariable objectReference="Metabolite_23"/>
      <StateTemplateVariable objectReference="Metabolite_27"/>
      <StateTemplateVariable objectReference="Metabolite_18"/>
      <StateTemplateVariable objectReference="Metabolite_22"/>
      <StateTemplateVariable objectReference="Metabolite_39"/>
      <StateTemplateVariable objectReference="Metabolite_31"/>
      <StateTemplateVariable objectReference="Metabolite_14"/>
      <StateTemplateVariable objectReference="Metabolite_28"/>
      <StateTemplateVariable objectReference="Metabolite_25"/>
      <StateTemplateVariable objectReference="Metabolite_10"/>
      <StateTemplateVariable objectReference="Metabolite_2"/>
      <StateTemplateVariable objectReference="Metabolite_6"/>
      <StateTemplateVariable objectReference="Metabolite_26"/>
      <StateTemplateVariable objectReference="Metabolite_32"/>
      <StateTemplateVariable objectReference="Metabolite_38"/>
      <StateTemplateVariable objectReference="Metabolite_35"/>
      <StateTemplateVariable objectReference="Metabolite_34"/>
      <StateTemplateVariable objectReference="Metabolite_40"/>
      <StateTemplateVariable objectReference="Compartment_0"/>
      <StateTemplateVariable objectReference="Compartment_1"/>
      <StateTemplateVariable objectReference="Compartment_2"/>
      <StateTemplateVariable objectReference="Compartment_3"/>
      <StateTemplateVariable objectReference="Compartment_4"/>
      <StateTemplateVariable objectReference="ModelValue_8"/>
      <StateTemplateVariable objectReference="ModelValue_9"/>
      <StateTemplateVariable objectReference="ModelValue_10"/>
      <StateTemplateVariable objectReference="ModelValue_11"/>
      <StateTemplateVariable objectReference="ModelValue_12"/>
      <StateTemplateVariable objectReference="ModelValue_13"/>
      <StateTemplateVariable objectReference="ModelValue_14"/>
      <StateTemplateVariable objectReference="ModelValue_15"/>
      <StateTemplateVariable objectReference="ModelValue_16"/>
      <StateTemplateVariable objectReference="ModelValue_17"/>
      <StateTemplateVariable objectReference="ModelValue_19"/>
      <StateTemplateVariable objectReference="ModelValue_21"/>
      <StateTemplateVariable objectReference="ModelValue_23"/>
      <StateTemplateVariable objectReference="ModelValue_25"/>
      <StateTemplateVariable objectReference="ModelValue_27"/>
      <StateTemplateVariable objectReference="ModelValue_29"/>
      <StateTemplateVariable objectReference="ModelValue_31"/>
      <StateTemplateVariable objectReference="ModelValue_33"/>
      <StateTemplateVariable objectReference="ModelValue_35"/>
      <StateTemplateVariable objectReference="ModelValue_37"/>
      <StateTemplateVariable objectReference="ModelValue_39"/>
      <StateTemplateVariable objectReference="ModelValue_41"/>
      <StateTemplateVariable objectReference="ModelValue_43"/>
      <StateTemplateVariable objectReference="ModelValue_59"/>
      <StateTemplateVariable objectReference="ModelValue_60"/>
      <StateTemplateVariable objectReference="ModelValue_64"/>
      <StateTemplateVariable objectReference="ModelValue_71"/>
      <StateTemplateVariable objectReference="ModelValue_79"/>
      <StateTemplateVariable objectReference="ModelValue_85"/>
      <StateTemplateVariable objectReference="ModelValue_96"/>
      <StateTemplateVariable objectReference="ModelValue_104"/>
      <StateTemplateVariable objectReference="ModelValue_117"/>
      <StateTemplateVariable objectReference="ModelValue_118"/>
      <StateTemplateVariable objectReference="ModelValue_123"/>
      <StateTemplateVariable objectReference="ModelValue_131"/>
      <StateTemplateVariable objectReference="ModelValue_137"/>
      <StateTemplateVariable objectReference="ModelValue_142"/>
      <StateTemplateVariable objectReference="ModelValue_147"/>
      <StateTemplateVariable objectReference="ModelValue_151"/>
      <StateTemplateVariable objectReference="ModelValue_152"/>
      <StateTemplateVariable objectReference="ModelValue_155"/>
      <StateTemplateVariable objectReference="ModelValue_7"/>
      <StateTemplateVariable objectReference="ModelValue_20"/>
      <StateTemplateVariable objectReference="ModelValue_24"/>
      <StateTemplateVariable objectReference="ModelValue_28"/>
      <StateTemplateVariable objectReference="ModelValue_32"/>
      <StateTemplateVariable objectReference="ModelValue_36"/>
      <StateTemplateVariable objectReference="ModelValue_40"/>
      <StateTemplateVariable objectReference="ModelValue_46"/>
      <StateTemplateVariable objectReference="ModelValue_47"/>
      <StateTemplateVariable objectReference="ModelValue_48"/>
      <StateTemplateVariable objectReference="ModelValue_49"/>
      <StateTemplateVariable objectReference="ModelValue_156"/>
      <StateTemplateVariable objectReference="ModelValue_157"/>
      <StateTemplateVariable objectReference="ModelValue_158"/>
      <StateTemplateVariable objectReference="Metabolite_0"/>
      <StateTemplateVariable objectReference="Metabolite_4"/>
      <StateTemplateVariable objectReference="Metabolite_8"/>
      <StateTemplateVariable objectReference="Metabolite_12"/>
      <StateTemplateVariable objectReference="Metabolite_16"/>
      <StateTemplateVariable objectReference="Metabolite_20"/>
      <StateTemplateVariable objectReference="ModelValue_0"/>
      <StateTemplateVariable objectReference="ModelValue_1"/>
      <StateTemplateVariable objectReference="ModelValue_2"/>
      <StateTemplateVariable objectReference="ModelValue_3"/>
      <StateTemplateVariable objectReference="ModelValue_4"/>
      <StateTemplateVariable objectReference="ModelValue_5"/>
      <StateTemplateVariable objectReference="ModelValue_6"/>
      <StateTemplateVariable objectReference="ModelValue_18"/>
      <StateTemplateVariable objectReference="ModelValue_22"/>
      <StateTemplateVariable objectReference="ModelValue_26"/>
      <StateTemplateVariable objectReference="ModelValue_30"/>
      <StateTemplateVariable objectReference="ModelValue_34"/>
      <StateTemplateVariable objectReference="ModelValue_38"/>
      <StateTemplateVariable objectReference="ModelValue_42"/>
      <StateTemplateVariable objectReference="ModelValue_44"/>
      <StateTemplateVariable objectReference="ModelValue_45"/>
      <StateTemplateVariable objectReference="ModelValue_50"/>
      <StateTemplateVariable objectReference="ModelValue_51"/>
      <StateTemplateVariable objectReference="ModelValue_52"/>
      <StateTemplateVariable objectReference="ModelValue_53"/>
      <StateTemplateVariable objectReference="ModelValue_54"/>
      <StateTemplateVariable objectReference="ModelValue_55"/>
      <StateTemplateVariable objectReference="ModelValue_56"/>
      <StateTemplateVariable objectReference="ModelValue_57"/>
      <StateTemplateVariable objectReference="ModelValue_58"/>
      <StateTemplateVariable objectReference="ModelValue_61"/>
      <StateTemplateVariable objectReference="ModelValue_62"/>
      <StateTemplateVariable objectReference="ModelValue_63"/>
      <StateTemplateVariable objectReference="ModelValue_65"/>
      <StateTemplateVariable objectReference="ModelValue_66"/>
      <StateTemplateVariable objectReference="ModelValue_67"/>
      <StateTemplateVariable objectReference="ModelValue_68"/>
      <StateTemplateVariable objectReference="ModelValue_69"/>
      <StateTemplateVariable objectReference="ModelValue_70"/>
      <StateTemplateVariable objectReference="ModelValue_72"/>
      <StateTemplateVariable objectReference="ModelValue_73"/>
      <StateTemplateVariable objectReference="ModelValue_74"/>
      <StateTemplateVariable objectReference="ModelValue_75"/>
      <StateTemplateVariable objectReference="ModelValue_76"/>
      <StateTemplateVariable objectReference="ModelValue_77"/>
      <StateTemplateVariable objectReference="ModelValue_78"/>
      <StateTemplateVariable objectReference="ModelValue_80"/>
      <StateTemplateVariable objectReference="ModelValue_81"/>
      <StateTemplateVariable objectReference="ModelValue_82"/>
      <StateTemplateVariable objectReference="ModelValue_83"/>
      <StateTemplateVariable objectReference="ModelValue_84"/>
      <StateTemplateVariable objectReference="ModelValue_86"/>
      <StateTemplateVariable objectReference="ModelValue_87"/>
      <StateTemplateVariable objectReference="ModelValue_88"/>
      <StateTemplateVariable objectReference="ModelValue_89"/>
      <StateTemplateVariable objectReference="ModelValue_90"/>
      <StateTemplateVariable objectReference="ModelValue_91"/>
      <StateTemplateVariable objectReference="ModelValue_92"/>
      <StateTemplateVariable objectReference="ModelValue_93"/>
      <StateTemplateVariable objectReference="ModelValue_94"/>
      <StateTemplateVariable objectReference="ModelValue_95"/>
      <StateTemplateVariable objectReference="ModelValue_97"/>
      <StateTemplateVariable objectReference="ModelValue_98"/>
      <StateTemplateVariable objectReference="ModelValue_99"/>
      <StateTemplateVariable objectReference="ModelValue_100"/>
      <StateTemplateVariable objectReference="ModelValue_101"/>
      <StateTemplateVariable objectReference="ModelValue_102"/>
      <StateTemplateVariable objectReference="ModelValue_103"/>
      <StateTemplateVariable objectReference="ModelValue_105"/>
      <StateTemplateVariable objectReference="ModelValue_106"/>
      <StateTemplateVariable objectReference="ModelValue_107"/>
      <StateTemplateVariable objectReference="ModelValue_108"/>
      <StateTemplateVariable objectReference="ModelValue_109"/>
      <StateTemplateVariable objectReference="ModelValue_110"/>
      <StateTemplateVariable objectReference="ModelValue_111"/>
      <StateTemplateVariable objectReference="ModelValue_112"/>
      <StateTemplateVariable objectReference="ModelValue_113"/>
      <StateTemplateVariable objectReference="ModelValue_114"/>
      <StateTemplateVariable objectReference="ModelValue_115"/>
      <StateTemplateVariable objectReference="ModelValue_116"/>
      <StateTemplateVariable objectReference="ModelValue_119"/>
      <StateTemplateVariable objectReference="ModelValue_120"/>
      <StateTemplateVariable objectReference="ModelValue_121"/>
      <StateTemplateVariable objectReference="ModelValue_122"/>
      <StateTemplateVariable objectReference="ModelValue_124"/>
      <StateTemplateVariable objectReference="ModelValue_125"/>
      <StateTemplateVariable objectReference="ModelValue_126"/>
      <StateTemplateVariable objectReference="ModelValue_127"/>
      <StateTemplateVariable objectReference="ModelValue_128"/>
      <StateTemplateVariable objectReference="ModelValue_129"/>
      <StateTemplateVariable objectReference="ModelValue_130"/>
      <StateTemplateVariable objectReference="ModelValue_132"/>
      <StateTemplateVariable objectReference="ModelValue_133"/>
      <StateTemplateVariable objectReference="ModelValue_134"/>
      <StateTemplateVariable objectReference="ModelValue_135"/>
      <StateTemplateVariable objectReference="ModelValue_136"/>
      <StateTemplateVariable objectReference="ModelValue_138"/>
      <StateTemplateVariable objectReference="ModelValue_139"/>
      <StateTemplateVariable objectReference="ModelValue_140"/>
      <StateTemplateVariable objectReference="ModelValue_141"/>
      <StateTemplateVariable objectReference="ModelValue_143"/>
      <StateTemplateVariable objectReference="ModelValue_144"/>
      <StateTemplateVariable objectReference="ModelValue_145"/>
      <StateTemplateVariable objectReference="ModelValue_146"/>
      <StateTemplateVariable objectReference="ModelValue_148"/>
      <StateTemplateVariable objectReference="ModelValue_149"/>
      <StateTemplateVariable objectReference="ModelValue_150"/>
      <StateTemplateVariable objectReference="ModelValue_153"/>
      <StateTemplateVariable objectReference="ModelValue_154"/>
    </StateTemplate>
    <InitialState type="initialState">
      0 492192637758.6914 0 0 2197644.561760465 0 0 0 98438527.55173826 33469099367.59102 11812623.30620859 265784024389.6934 8859467479.656443 0 0 0 2197644.561760465 0 0 1181262330.620859 0 0 9843852755.17383 10828238030.69121 871792.8840041513 11812623306.20859 0 0 0 0 0 98438527.55173826 787508220.4139061 26578402438.96935 118126233062.0859 9843852755.17383 3.04106168867492e-13 3.04106168867492e-14 1.206371578978481e-14 3.04106168867492e-14 1.63460992757094e-13 0.0005 0.0005 6.08212337734984e-11 2.412743157956961e-11 1.382300767579509e-08 3.04106168867492e-14 1.206371578978481e-14 1.63460992757094e-13 3.04106168867492e-13 3.04106168867492e-14 0 0 4.865698701879872e-17 6.911503837897545e-12 1.216424675469968e-17 1.727875959474386e-12 4.865698701879872e-17 6.911503837897545e-12 4.865698701879872e-17 6.911503837897545e-12 2.432849350939936e-16 3.455751918948773e-11 1e-14 8.7e-15 81.92337921972911 4.35e-16 8.7e-13 8.7e-09 8.7e-19 6.9948e-14 2.612088e-15 1.74e-11 10.18490079862424 8.7e-13 3.48e-11 4.35e-13 4.35e-14 1.74e-16 1e-08 1.000002807017544 1e-13 1 0 1.930194526365569e-17 4.825486315913922e-18 1.930194526365569e-17 1.930194526365569e-17 9.650972631827844e-17 0.2 3.9 0.8100000000000002 17.539 0 0 0 0 0 0 21976445.61760465 0 0 0.0005 4.4e-06 8e-07 6.25e-06 6e-05 1 1 0 4e-10 1e-10 4e-10 4e-10 2e-09 1e-14 1 0 0.1 50 1.5 0.8 5.3 8.699999999999999 0.97 0.034 1 0.05 0.35 1 100 0.58 0.1 0.5 0.1 1 1000000 4 40 40 0.1 0.1 1 1e-10 1 0.015 0.01 1 0.01 1 0.37 0.5 0.13 0.35 804 1.25 0.43 1 0.3 0.0278 36 0.33 0.06900000000000001 0.3 1 2000 0.01 0.45 0.5629999999999999 0.172 0.049 0.166 5 0.42 0.643 0.643 1 0.05 0.07000000000000001 4 1 2 1 1.33 0.042 27 0.19 1 50 10 0.67 0.045 1 0.1 0.12 0.2 1 0.02 0.1 0.1 1 1000000 85.5 1 10 1 
    </InitialState>
  </Model>
  <ListOfTasks>
    <Task key="Task_12" name="Steady-State" type="steadyState" scheduled="false" updateModel="false">
      <Report reference="Report_8" target="" append="1" confirmOverwrite="1"/>
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
    <Task key="Task_11" name="Time-Course" type="timeCourse" scheduled="false" updateModel="false">
      <Problem>
        <Parameter name="StepNumber" type="unsignedInteger" value="600"/>
        <Parameter name="StepSize" type="float" value="0.1"/>
        <Parameter name="Duration" type="float" value="60"/>
        <Parameter name="TimeSeriesRequested" type="bool" value="1"/>
        <Parameter name="OutputStartTime" type="float" value="0"/>
        <Parameter name="Output Event" type="bool" value="0"/>
      </Problem>
      <Method name="Deterministic (LSODA)" type="Deterministic(LSODA)">
        <Parameter name="Integrate Reduced Model" type="bool" value="0"/>
        <Parameter name="Relative Tolerance" type="unsignedFloat" value="1e-06"/>
        <Parameter name="Absolute Tolerance" type="unsignedFloat" value="1e-12"/>
        <Parameter name="Max Internal Steps" type="unsignedInteger" value="10000"/>
      </Method>
    </Task>
    <Task key="Task_10" name="Scan" type="scan" scheduled="false" updateModel="false">
      <Problem>
        <Parameter name="Subtask" type="unsignedInteger" value="1"/>
        <ParameterGroup name="ScanItems">
        </ParameterGroup>
        <Parameter name="Output in subtask" type="bool" value="1"/>
        <Parameter name="Adjust initial conditions" type="bool" value="0"/>
      </Problem>
      <Method name="Scan Framework" type="ScanFramework">
      </Method>
    </Task>
    <Task key="Task_9" name="Elementary Flux Modes" type="fluxMode" scheduled="false" updateModel="false">
      <Report reference="Report_7" target="" append="1" confirmOverwrite="1"/>
      <Problem>
      </Problem>
      <Method name="EFM Algorithm" type="EFMAlgorithm">
      </Method>
    </Task>
    <Task key="Task_8" name="Optimization" type="optimization" scheduled="false" updateModel="false">
      <Report reference="Report_6" target="" append="1" confirmOverwrite="1"/>
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
    <Task key="Task_7" name="Parameter Estimation" type="parameterFitting" scheduled="false" updateModel="false">
      <Report reference="Report_5" target="" append="1" confirmOverwrite="1"/>
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
    <Task key="Task_6" name="Metabolic Control Analysis" type="metabolicControlAnalysis" scheduled="false" updateModel="false">
      <Report reference="Report_4" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="Steady-State" type="key" value="Task_12"/>
      </Problem>
      <Method name="MCA Method (Reder)" type="MCAMethod(Reder)">
        <Parameter name="Modulation Factor" type="unsignedFloat" value="1e-09"/>
      </Method>
    </Task>
    <Task key="Task_5" name="Lyapunov Exponents" type="lyapunovExponents" scheduled="false" updateModel="false">
      <Report reference="Report_3" target="" append="1" confirmOverwrite="1"/>
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
    <Task key="Task_4" name="Time Scale Separation Analysis" type="timeScaleSeparationAnalysis" scheduled="false" updateModel="false">
      <Report reference="Report_2" target="" append="1" confirmOverwrite="1"/>
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
    <Task key="Task_3" name="Sensitivities" type="sensitivities" scheduled="false" updateModel="false">
      <Report reference="Report_1" target="" append="1" confirmOverwrite="1"/>
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
    <Task key="Task_2" name="Moieties" type="moieties" scheduled="false" updateModel="false">
      <Problem>
      </Problem>
      <Method name="Householder Reduction" type="Householder">
      </Method>
    </Task>
    <Task key="Task_1" name="Cross Section" type="crosssection" scheduled="false" updateModel="false">
      <Problem>
        <Parameter name="StepNumber" type="unsignedInteger" value="100"/>
        <Parameter name="StepSize" type="float" value="0.01"/>
        <Parameter name="Duration" type="float" value="1"/>
        <Parameter name="TimeSeriesRequested" type="bool" value="1"/>
        <Parameter name="OutputStartTime" type="float" value="0"/>
        <Parameter name="Output Event" type="bool" value="0"/>
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
    <Task key="Task_13" name="Linear Noise Approximation" type="linearNoiseApproximation" scheduled="false" updateModel="false">
      <Report reference="Report_0" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="Steady-State" type="key" value="Task_12"/>
      </Problem>
      <Method name="Linear Noise Approximation" type="LinearNoiseApproximation">
      </Method>
    </Task>
  </ListOfTasks>
  <ListOfReports>
    <Report key="Report_8" name="Steady-State" taskType="steadyState" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Footer>
        <Object cn="CN=Root,Vector=TaskList[Steady-State]"/>
      </Footer>
    </Report>
    <Report key="Report_7" name="Elementary Flux Modes" taskType="fluxMode" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Footer>
        <Object cn="CN=Root,Vector=TaskList[Elementary Flux Modes],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_6" name="Optimization" taskType="optimization" separator="&#x09;" precision="6">
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
    <Report key="Report_5" name="Parameter Estimation" taskType="parameterFitting" separator="&#x09;" precision="6">
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
    <Report key="Report_4" name="Metabolic Control Analysis" taskType="metabolicControlAnalysis" separator="&#x09;" precision="6">
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
    <Report key="Report_3" name="Lyapunov Exponents" taskType="lyapunovExponents" separator="&#x09;" precision="6">
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
    <Report key="Report_2" name="Time Scale Separation Analysis" taskType="timeScaleSeparationAnalysis" separator="&#x09;" precision="6">
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
    <Report key="Report_1" name="Sensitivities" taskType="sensitivities" separator="&#x09;" precision="6">
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
    <Report key="Report_0" name="Linear Noise Approximation" taskType="linearNoiseApproximation" separator="&#x09;" precision="6">
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
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[ADP],Reference=Concentration"/>
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
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[ATP],Reference=Concentration"/>
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
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[D-galactitol],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[D-galactose M]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[D-galactose M],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[D-galactose-1-phosphate]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[D-galactose-1-phosphate],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[D-galactose]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[D-galactose],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[D-glucose-1-phosphate]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[D-glucose-1-phosphate],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[D-glucose-6-phosphate]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[D-glucose-6-phosphate],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[H2O M]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[H2O M],Reference=Concentration"/>
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
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[NADPH],Reference=Concentration"/>
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
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[NADP],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Phosphate]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[Phosphate],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[Pyrophosphate]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[Pyrophosphate],Reference=Concentration"/>
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
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[UDP-D-galactose],Reference=Concentration"/>
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
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[UDP-D-glucose],Reference=Concentration"/>
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
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[UDP],Reference=Concentration"/>
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
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[H01],Vector=Metabolites[UTP],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[alb{D001}]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[D001],Vector=Metabolites[alb],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[alb{PP}]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[PP],Vector=Metabolites[alb],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[alb{PV}]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[PV],Vector=Metabolites[alb],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[alb{S001}]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[S001],Vector=Metabolites[alb],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[galM{D001}]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[D001],Vector=Metabolites[galM],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[galM{PP}]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[PP],Vector=Metabolites[galM],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[galM{PV}]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[PV],Vector=Metabolites[galM],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[galM{S001}]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[S001],Vector=Metabolites[galM],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[gal{D001}]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[D001],Vector=Metabolites[gal],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[gal{PP}]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[PP],Vector=Metabolites[gal],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[gal{PV}]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[PV],Vector=Metabolites[gal],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[gal{S001}]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[S001],Vector=Metabolites[gal],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[h2oM{D001}]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[D001],Vector=Metabolites[h2oM],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[h2oM{PP}]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[PP],Vector=Metabolites[h2oM],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[h2oM{PV}]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[PV],Vector=Metabolites[h2oM],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[h2oM{S001}]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[S001],Vector=Metabolites[h2oM],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[rbcM{D001}]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[D001],Vector=Metabolites[rbcM],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[rbcM{PP}]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[PP],Vector=Metabolites[rbcM],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[rbcM{PV}]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[PV],Vector=Metabolites[rbcM],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[rbcM{S001}]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[S001],Vector=Metabolites[rbcM],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[suc{D001}]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[D001],Vector=Metabolites[suc],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[suc{PP}]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[PP],Vector=Metabolites[suc],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[suc{PV}]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[PV],Vector=Metabolites[suc],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[suc{S001}]|Time" type="Curve2D">
          <Parameter name="Color" type="string" value="auto"/>
          <Parameter name="Line subtype" type="unsignedInteger" value="0"/>
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Line width" type="unsignedFloat" value="1"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <Parameter name="Symbol subtype" type="unsignedInteger" value="0"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=NoName,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=NoName,Vector=Compartments[S001],Vector=Metabolites[suc],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
      </ListOfPlotItems>
    </PlotSpecification>
  </ListOfPlots>
  <GUI>
  </GUI>
  <SBMLReference file="Galactose_Dilution_v3_Nc1_Nf1.xml">
    <SBMLMap SBMLid="ALDR_f" COPASIkey="ModelValue_72"/>
    <SBMLMap SBMLid="ALDR_k_gal" COPASIkey="ModelValue_74"/>
    <SBMLMap SBMLid="ALDR_k_galtol" COPASIkey="ModelValue_75"/>
    <SBMLMap SBMLid="ALDR_k_nadp" COPASIkey="ModelValue_76"/>
    <SBMLMap SBMLid="ALDR_k_nadph" COPASIkey="ModelValue_77"/>
    <SBMLMap SBMLid="ALDR_keq" COPASIkey="ModelValue_73"/>
    <SBMLMap SBMLid="ATPS_f" COPASIkey="ModelValue_65"/>
    <SBMLMap SBMLid="ATPS_k_adp" COPASIkey="ModelValue_67"/>
    <SBMLMap SBMLid="ATPS_k_atp" COPASIkey="ModelValue_68"/>
    <SBMLMap SBMLid="ATPS_k_phos" COPASIkey="ModelValue_69"/>
    <SBMLMap SBMLid="ATPS_keq" COPASIkey="ModelValue_66"/>
    <SBMLMap SBMLid="A_dis" COPASIkey="ModelValue_11"/>
    <SBMLMap SBMLid="A_sin" COPASIkey="ModelValue_10"/>
    <SBMLMap SBMLid="A_sindis" COPASIkey="ModelValue_12"/>
    <SBMLMap SBMLid="D001" COPASIkey="Compartment_2"/>
    <SBMLMap SBMLid="D001__GLUT2_GAL" COPASIkey="Reaction_52"/>
    <SBMLMap SBMLid="D001__GLUT2_GALM" COPASIkey="Reaction_53"/>
    <SBMLMap SBMLid="D001__H2OTM" COPASIkey="Reaction_54"/>
    <SBMLMap SBMLid="D001__alb" COPASIkey="Metabolite_10"/>
    <SBMLMap SBMLid="D001__gal" COPASIkey="Metabolite_14"/>
    <SBMLMap SBMLid="D001__galM" COPASIkey="Metabolite_18"/>
    <SBMLMap SBMLid="D001__h2oM" COPASIkey="Metabolite_22"/>
    <SBMLMap SBMLid="D001__rbcM" COPASIkey="Metabolite_2"/>
    <SBMLMap SBMLid="D001__suc" COPASIkey="Metabolite_6"/>
    <SBMLMap SBMLid="Dalb" COPASIkey="ModelValue_26"/>
    <SBMLMap SBMLid="Dgal" COPASIkey="ModelValue_30"/>
    <SBMLMap SBMLid="DgalM" COPASIkey="ModelValue_34"/>
    <SBMLMap SBMLid="Dh2oM" COPASIkey="ModelValue_38"/>
    <SBMLMap SBMLid="DiffPPS001_alb" COPASIkey="Reaction_24"/>
    <SBMLMap SBMLid="DiffPPS001_gal" COPASIkey="Reaction_27"/>
    <SBMLMap SBMLid="DiffPPS001_galM" COPASIkey="Reaction_30"/>
    <SBMLMap SBMLid="DiffPPS001_h2oM" COPASIkey="Reaction_33"/>
    <SBMLMap SBMLid="DiffPPS001_rbcM" COPASIkey="Reaction_18"/>
    <SBMLMap SBMLid="DiffPPS001_suc" COPASIkey="Reaction_21"/>
    <SBMLMap SBMLid="DiffS001D001_alb" COPASIkey="Reaction_26"/>
    <SBMLMap SBMLid="DiffS001D001_gal" COPASIkey="Reaction_29"/>
    <SBMLMap SBMLid="DiffS001D001_galM" COPASIkey="Reaction_32"/>
    <SBMLMap SBMLid="DiffS001D001_h2oM" COPASIkey="Reaction_35"/>
    <SBMLMap SBMLid="DiffS001D001_rbcM" COPASIkey="Reaction_20"/>
    <SBMLMap SBMLid="DiffS001D001_suc" COPASIkey="Reaction_23"/>
    <SBMLMap SBMLid="DiffS001PV_alb" COPASIkey="Reaction_25"/>
    <SBMLMap SBMLid="DiffS001PV_gal" COPASIkey="Reaction_28"/>
    <SBMLMap SBMLid="DiffS001PV_galM" COPASIkey="Reaction_31"/>
    <SBMLMap SBMLid="DiffS001PV_h2oM" COPASIkey="Reaction_34"/>
    <SBMLMap SBMLid="DiffS001PV_rbcM" COPASIkey="Reaction_19"/>
    <SBMLMap SBMLid="DiffS001PV_suc" COPASIkey="Reaction_22"/>
    <SBMLMap SBMLid="DrbcM" COPASIkey="ModelValue_18"/>
    <SBMLMap SBMLid="Dsuc" COPASIkey="ModelValue_22"/>
    <SBMLMap SBMLid="Dx_dis_alb" COPASIkey="ModelValue_28"/>
    <SBMLMap SBMLid="Dx_dis_gal" COPASIkey="ModelValue_32"/>
    <SBMLMap SBMLid="Dx_dis_galM" COPASIkey="ModelValue_36"/>
    <SBMLMap SBMLid="Dx_dis_h2oM" COPASIkey="ModelValue_40"/>
    <SBMLMap SBMLid="Dx_dis_rbcM" COPASIkey="ModelValue_20"/>
    <SBMLMap SBMLid="Dx_dis_suc" COPASIkey="ModelValue_24"/>
    <SBMLMap SBMLid="Dx_sin_alb" COPASIkey="ModelValue_27"/>
    <SBMLMap SBMLid="Dx_sin_gal" COPASIkey="ModelValue_31"/>
    <SBMLMap SBMLid="Dx_sin_galM" COPASIkey="ModelValue_35"/>
    <SBMLMap SBMLid="Dx_sin_h2oM" COPASIkey="ModelValue_39"/>
    <SBMLMap SBMLid="Dx_sin_rbcM" COPASIkey="ModelValue_19"/>
    <SBMLMap SBMLid="Dx_sin_suc" COPASIkey="ModelValue_23"/>
    <SBMLMap SBMLid="Dy_sindis_alb" COPASIkey="ModelValue_29"/>
    <SBMLMap SBMLid="Dy_sindis_gal" COPASIkey="ModelValue_33"/>
    <SBMLMap SBMLid="Dy_sindis_galM" COPASIkey="ModelValue_37"/>
    <SBMLMap SBMLid="Dy_sindis_h2oM" COPASIkey="ModelValue_41"/>
    <SBMLMap SBMLid="Dy_sindis_rbcM" COPASIkey="ModelValue_21"/>
    <SBMLMap SBMLid="Dy_sindis_suc" COPASIkey="ModelValue_25"/>
    <SBMLMap SBMLid="EDEF_00" COPASIkey="Event_0"/>
    <SBMLMap SBMLid="EDEF_01" COPASIkey="Event_1"/>
    <SBMLMap SBMLid="EDEF_02" COPASIkey="Event_2"/>
    <SBMLMap SBMLid="EDEF_03" COPASIkey="Event_3"/>
    <SBMLMap SBMLid="EDEF_04" COPASIkey="Event_4"/>
    <SBMLMap SBMLid="EDEF_05" COPASIkey="Event_5"/>
    <SBMLMap SBMLid="EDEF_06" COPASIkey="Event_6"/>
    <SBMLMap SBMLid="EDEF_07" COPASIkey="Event_7"/>
    <SBMLMap SBMLid="EDEF_08" COPASIkey="Event_8"/>
    <SBMLMap SBMLid="EDEF_09" COPASIkey="Event_9"/>
    <SBMLMap SBMLid="EDEF_10" COPASIkey="Event_10"/>
    <SBMLMap SBMLid="EDEF_11" COPASIkey="Event_11"/>
    <SBMLMap SBMLid="EDEF_12" COPASIkey="Event_12"/>
    <SBMLMap SBMLid="EDEF_13" COPASIkey="Event_13"/>
    <SBMLMap SBMLid="EDEF_14" COPASIkey="Event_14"/>
    <SBMLMap SBMLid="EDEF_15" COPASIkey="Event_15"/>
    <SBMLMap SBMLid="EDEF_16" COPASIkey="Event_16"/>
    <SBMLMap SBMLid="EDEF_17" COPASIkey="Event_17"/>
    <SBMLMap SBMLid="EDEF_18" COPASIkey="Event_18"/>
    <SBMLMap SBMLid="EDEF_19" COPASIkey="Event_19"/>
    <SBMLMap SBMLid="EDEF_20" COPASIkey="Event_20"/>
    <SBMLMap SBMLid="EDEF_21" COPASIkey="Event_21"/>
    <SBMLMap SBMLid="EDEF_22" COPASIkey="Event_22"/>
    <SBMLMap SBMLid="EDEF_23" COPASIkey="Event_23"/>
    <SBMLMap SBMLid="EDIL_1" COPASIkey="Event_24"/>
    <SBMLMap SBMLid="EDIL_2" COPASIkey="Event_25"/>
    <SBMLMap SBMLid="FlowPPS001_alb" COPASIkey="Reaction_6"/>
    <SBMLMap SBMLid="FlowPPS001_gal" COPASIkey="Reaction_9"/>
    <SBMLMap SBMLid="FlowPPS001_galM" COPASIkey="Reaction_12"/>
    <SBMLMap SBMLid="FlowPPS001_h2oM" COPASIkey="Reaction_15"/>
    <SBMLMap SBMLid="FlowPPS001_rbcM" COPASIkey="Reaction_0"/>
    <SBMLMap SBMLid="FlowPPS001_suc" COPASIkey="Reaction_3"/>
    <SBMLMap SBMLid="FlowPVNULL_alb" COPASIkey="Reaction_8"/>
    <SBMLMap SBMLid="FlowPVNULL_gal" COPASIkey="Reaction_11"/>
    <SBMLMap SBMLid="FlowPVNULL_galM" COPASIkey="Reaction_14"/>
    <SBMLMap SBMLid="FlowPVNULL_h2oM" COPASIkey="Reaction_17"/>
    <SBMLMap SBMLid="FlowPVNULL_rbcM" COPASIkey="Reaction_2"/>
    <SBMLMap SBMLid="FlowPVNULL_suc" COPASIkey="Reaction_5"/>
    <SBMLMap SBMLid="FlowS001PV_alb" COPASIkey="Reaction_7"/>
    <SBMLMap SBMLid="FlowS001PV_gal" COPASIkey="Reaction_10"/>
    <SBMLMap SBMLid="FlowS001PV_galM" COPASIkey="Reaction_13"/>
    <SBMLMap SBMLid="FlowS001PV_h2oM" COPASIkey="Reaction_16"/>
    <SBMLMap SBMLid="FlowS001PV_rbcM" COPASIkey="Reaction_1"/>
    <SBMLMap SBMLid="FlowS001PV_suc" COPASIkey="Reaction_4"/>
    <SBMLMap SBMLid="GALE_PA" COPASIkey="ModelValue_98"/>
    <SBMLMap SBMLid="GALE_f" COPASIkey="ModelValue_97"/>
    <SBMLMap SBMLid="GALE_k_udpgal" COPASIkey="ModelValue_102"/>
    <SBMLMap SBMLid="GALE_k_udpglc" COPASIkey="ModelValue_101"/>
    <SBMLMap SBMLid="GALE_kcat" COPASIkey="ModelValue_99"/>
    <SBMLMap SBMLid="GALE_keq" COPASIkey="ModelValue_100"/>
    <SBMLMap SBMLid="GALK_PA" COPASIkey="ModelValue_50"/>
    <SBMLMap SBMLid="GALK_k_adp" COPASIkey="ModelValue_53"/>
    <SBMLMap SBMLid="GALK_k_atp" COPASIkey="ModelValue_57"/>
    <SBMLMap SBMLid="GALK_k_gal" COPASIkey="ModelValue_56"/>
    <SBMLMap SBMLid="GALK_k_gal1p" COPASIkey="ModelValue_52"/>
    <SBMLMap SBMLid="GALK_kcat" COPASIkey="ModelValue_55"/>
    <SBMLMap SBMLid="GALK_keq" COPASIkey="ModelValue_51"/>
    <SBMLMap SBMLid="GALK_ki_gal1p" COPASIkey="ModelValue_54"/>
    <SBMLMap SBMLid="GALT_f" COPASIkey="ModelValue_86"/>
    <SBMLMap SBMLid="GALT_k_gal1p" COPASIkey="ModelValue_93"/>
    <SBMLMap SBMLid="GALT_k_glc1p" COPASIkey="ModelValue_88"/>
    <SBMLMap SBMLid="GALT_k_udpgal" COPASIkey="ModelValue_89"/>
    <SBMLMap SBMLid="GALT_k_udpglc" COPASIkey="ModelValue_94"/>
    <SBMLMap SBMLid="GALT_keq" COPASIkey="ModelValue_87"/>
    <SBMLMap SBMLid="GALT_ki_udp" COPASIkey="ModelValue_91"/>
    <SBMLMap SBMLid="GALT_ki_utp" COPASIkey="ModelValue_90"/>
    <SBMLMap SBMLid="GALT_vm" COPASIkey="ModelValue_92"/>
    <SBMLMap SBMLid="GLUT2_f" COPASIkey="ModelValue_148"/>
    <SBMLMap SBMLid="GLUT2_k_gal" COPASIkey="ModelValue_149"/>
    <SBMLMap SBMLid="GLY_f" COPASIkey="ModelValue_138"/>
    <SBMLMap SBMLid="GLY_k_glc6p" COPASIkey="ModelValue_139"/>
    <SBMLMap SBMLid="GLY_k_p" COPASIkey="ModelValue_140"/>
    <SBMLMap SBMLid="GTF_f" COPASIkey="ModelValue_143"/>
    <SBMLMap SBMLid="GTF_k_udpgal" COPASIkey="ModelValue_144"/>
    <SBMLMap SBMLid="GTF_k_udpglc" COPASIkey="ModelValue_145"/>
    <SBMLMap SBMLid="H01" COPASIkey="Compartment_4"/>
    <SBMLMap SBMLid="H01__ALDR" COPASIkey="Reaction_40"/>
    <SBMLMap SBMLid="H01__ALDR_P" COPASIkey="ModelValue_78"/>
    <SBMLMap SBMLid="H01__ALDR_Vmax" COPASIkey="ModelValue_79"/>
    <SBMLMap SBMLid="H01__ATPS" COPASIkey="Reaction_39"/>
    <SBMLMap SBMLid="H01__ATPS_P" COPASIkey="ModelValue_70"/>
    <SBMLMap SBMLid="H01__ATPS_Vmax" COPASIkey="ModelValue_71"/>
    <SBMLMap SBMLid="H01__GALE" COPASIkey="Reaction_43"/>
    <SBMLMap SBMLid="H01__GALE_P" COPASIkey="ModelValue_103"/>
    <SBMLMap SBMLid="H01__GALE_Vmax" COPASIkey="ModelValue_104"/>
    <SBMLMap SBMLid="H01__GALK" COPASIkey="Reaction_36"/>
    <SBMLMap SBMLid="H01__GALKM" COPASIkey="Reaction_37"/>
    <SBMLMap SBMLid="H01__GALK_P" COPASIkey="ModelValue_58"/>
    <SBMLMap SBMLid="H01__GALK_Vmax" COPASIkey="ModelValue_59"/>
    <SBMLMap SBMLid="H01__GALK_dm" COPASIkey="ModelValue_60"/>
    <SBMLMap SBMLid="H01__GALT" COPASIkey="Reaction_42"/>
    <SBMLMap SBMLid="H01__GALT_P" COPASIkey="ModelValue_95"/>
    <SBMLMap SBMLid="H01__GALT_Vmax" COPASIkey="ModelValue_96"/>
    <SBMLMap SBMLid="H01__GLUT2_GAL" COPASIkey="ModelValue_157"/>
    <SBMLMap SBMLid="H01__GLUT2_GALM" COPASIkey="ModelValue_158"/>
    <SBMLMap SBMLid="H01__GLUT2_P" COPASIkey="ModelValue_150"/>
    <SBMLMap SBMLid="H01__GLUT2_Vmax" COPASIkey="ModelValue_151"/>
    <SBMLMap SBMLid="H01__GLUT2_dm" COPASIkey="ModelValue_152"/>
    <SBMLMap SBMLid="H01__GLY" COPASIkey="Reaction_49"/>
    <SBMLMap SBMLid="H01__GLY_P" COPASIkey="ModelValue_141"/>
    <SBMLMap SBMLid="H01__GLY_Vmax" COPASIkey="ModelValue_142"/>
    <SBMLMap SBMLid="H01__GTFGAL" COPASIkey="Reaction_50"/>
    <SBMLMap SBMLid="H01__GTFGLC" COPASIkey="Reaction_51"/>
    <SBMLMap SBMLid="H01__GTF_P" COPASIkey="ModelValue_146"/>
    <SBMLMap SBMLid="H01__GTF_Vmax" COPASIkey="ModelValue_147"/>
    <SBMLMap SBMLid="H01__H2OTM" COPASIkey="ModelValue_156"/>
    <SBMLMap SBMLid="H01__H2OT_Vmax" COPASIkey="ModelValue_155"/>
    <SBMLMap SBMLid="H01__IMP" COPASIkey="Reaction_38"/>
    <SBMLMap SBMLid="H01__IMP_P" COPASIkey="ModelValue_63"/>
    <SBMLMap SBMLid="H01__IMP_Vmax" COPASIkey="ModelValue_64"/>
    <SBMLMap SBMLid="H01__NADPR" COPASIkey="Reaction_41"/>
    <SBMLMap SBMLid="H01__NADPR_P" COPASIkey="ModelValue_84"/>
    <SBMLMap SBMLid="H01__NADPR_Vmax" COPASIkey="ModelValue_85"/>
    <SBMLMap SBMLid="H01__NDKU" COPASIkey="Reaction_47"/>
    <SBMLMap SBMLid="H01__NDKU_P" COPASIkey="ModelValue_130"/>
    <SBMLMap SBMLid="H01__NDKU_Vmax" COPASIkey="ModelValue_131"/>
    <SBMLMap SBMLid="H01__PGM1" COPASIkey="Reaction_48"/>
    <SBMLMap SBMLid="H01__PGM1_P" COPASIkey="ModelValue_136"/>
    <SBMLMap SBMLid="H01__PGM1_Vmax" COPASIkey="ModelValue_137"/>
    <SBMLMap SBMLid="H01__PPASE" COPASIkey="Reaction_46"/>
    <SBMLMap SBMLid="H01__PPASE_P" COPASIkey="ModelValue_122"/>
    <SBMLMap SBMLid="H01__PPASE_Vmax" COPASIkey="ModelValue_123"/>
    <SBMLMap SBMLid="H01__UGALP" COPASIkey="Reaction_45"/>
    <SBMLMap SBMLid="H01__UGP" COPASIkey="Reaction_44"/>
    <SBMLMap SBMLid="H01__UGP_P" COPASIkey="ModelValue_116"/>
    <SBMLMap SBMLid="H01__UGP_Vmax" COPASIkey="ModelValue_117"/>
    <SBMLMap SBMLid="H01__UGP_dm" COPASIkey="ModelValue_118"/>
    <SBMLMap SBMLid="H01__adp" COPASIkey="Metabolite_34"/>
    <SBMLMap SBMLid="H01__adp_tot" COPASIkey="ModelValue_47"/>
    <SBMLMap SBMLid="H01__atp" COPASIkey="Metabolite_33"/>
    <SBMLMap SBMLid="H01__gal" COPASIkey="Metabolite_24"/>
    <SBMLMap SBMLid="H01__gal1p" COPASIkey="Metabolite_29"/>
    <SBMLMap SBMLid="H01__galM" COPASIkey="Metabolite_25"/>
    <SBMLMap SBMLid="H01__galtol" COPASIkey="Metabolite_32"/>
    <SBMLMap SBMLid="H01__glc1p" COPASIkey="Metabolite_27"/>
    <SBMLMap SBMLid="H01__glc6p" COPASIkey="Metabolite_28"/>
    <SBMLMap SBMLid="H01__h2oM" COPASIkey="Metabolite_26"/>
    <SBMLMap SBMLid="H01__nadp" COPASIkey="Metabolite_39"/>
    <SBMLMap SBMLid="H01__nadp_tot" COPASIkey="ModelValue_46"/>
    <SBMLMap SBMLid="H01__nadph" COPASIkey="Metabolite_40"/>
    <SBMLMap SBMLid="H01__phos" COPASIkey="Metabolite_37"/>
    <SBMLMap SBMLid="H01__phos_tot" COPASIkey="ModelValue_49"/>
    <SBMLMap SBMLid="H01__ppi" COPASIkey="Metabolite_38"/>
    <SBMLMap SBMLid="H01__udp" COPASIkey="Metabolite_36"/>
    <SBMLMap SBMLid="H01__udp_tot" COPASIkey="ModelValue_48"/>
    <SBMLMap SBMLid="H01__udpgal" COPASIkey="Metabolite_31"/>
    <SBMLMap SBMLid="H01__udpglc" COPASIkey="Metabolite_30"/>
    <SBMLMap SBMLid="H01__utp" COPASIkey="Metabolite_35"/>
    <SBMLMap SBMLid="H2OT_f" COPASIkey="ModelValue_153"/>
    <SBMLMap SBMLid="H2OT_k" COPASIkey="ModelValue_154"/>
    <SBMLMap SBMLid="IMP_f" COPASIkey="ModelValue_61"/>
    <SBMLMap SBMLid="IMP_k_gal1p" COPASIkey="ModelValue_62"/>
    <SBMLMap SBMLid="L" COPASIkey="ModelValue_0"/>
    <SBMLMap SBMLid="NADPR_f" COPASIkey="ModelValue_80"/>
    <SBMLMap SBMLid="NADPR_k_nadp" COPASIkey="ModelValue_82"/>
    <SBMLMap SBMLid="NADPR_keq" COPASIkey="ModelValue_81"/>
    <SBMLMap SBMLid="NADPR_ki_nadph" COPASIkey="ModelValue_83"/>
    <SBMLMap SBMLid="NDKU_f" COPASIkey="ModelValue_124"/>
    <SBMLMap SBMLid="NDKU_k_adp" COPASIkey="ModelValue_127"/>
    <SBMLMap SBMLid="NDKU_k_atp" COPASIkey="ModelValue_126"/>
    <SBMLMap SBMLid="NDKU_k_udp" COPASIkey="ModelValue_129"/>
    <SBMLMap SBMLid="NDKU_k_utp" COPASIkey="ModelValue_128"/>
    <SBMLMap SBMLid="NDKU_keq" COPASIkey="ModelValue_125"/>
    <SBMLMap SBMLid="Nb" COPASIkey="ModelValue_7"/>
    <SBMLMap SBMLid="Nc" COPASIkey="ModelValue_5"/>
    <SBMLMap SBMLid="Nf" COPASIkey="ModelValue_6"/>
    <SBMLMap SBMLid="PGM1_f" COPASIkey="ModelValue_132"/>
    <SBMLMap SBMLid="PGM1_k_glc1p" COPASIkey="ModelValue_135"/>
    <SBMLMap SBMLid="PGM1_k_glc6p" COPASIkey="ModelValue_134"/>
    <SBMLMap SBMLid="PGM1_keq" COPASIkey="ModelValue_133"/>
    <SBMLMap SBMLid="PP" COPASIkey="Compartment_0"/>
    <SBMLMap SBMLid="PPASE_f" COPASIkey="ModelValue_119"/>
    <SBMLMap SBMLid="PPASE_k_ppi" COPASIkey="ModelValue_120"/>
    <SBMLMap SBMLid="PPASE_n" COPASIkey="ModelValue_121"/>
    <SBMLMap SBMLid="PP__alb" COPASIkey="Metabolite_8"/>
    <SBMLMap SBMLid="PP__gal" COPASIkey="Metabolite_12"/>
    <SBMLMap SBMLid="PP__galM" COPASIkey="Metabolite_16"/>
    <SBMLMap SBMLid="PP__h2oM" COPASIkey="Metabolite_20"/>
    <SBMLMap SBMLid="PP__rbcM" COPASIkey="Metabolite_0"/>
    <SBMLMap SBMLid="PP__suc" COPASIkey="Metabolite_4"/>
    <SBMLMap SBMLid="PV" COPASIkey="Compartment_3"/>
    <SBMLMap SBMLid="PV__alb" COPASIkey="Metabolite_11"/>
    <SBMLMap SBMLid="PV__gal" COPASIkey="Metabolite_15"/>
    <SBMLMap SBMLid="PV__galM" COPASIkey="Metabolite_19"/>
    <SBMLMap SBMLid="PV__h2oM" COPASIkey="Metabolite_23"/>
    <SBMLMap SBMLid="PV__rbcM" COPASIkey="Metabolite_3"/>
    <SBMLMap SBMLid="PV__suc" COPASIkey="Metabolite_7"/>
    <SBMLMap SBMLid="REF_P" COPASIkey="ModelValue_44"/>
    <SBMLMap SBMLid="S001" COPASIkey="Compartment_1"/>
    <SBMLMap SBMLid="S001__alb" COPASIkey="Metabolite_9"/>
    <SBMLMap SBMLid="S001__gal" COPASIkey="Metabolite_13"/>
    <SBMLMap SBMLid="S001__galM" COPASIkey="Metabolite_17"/>
    <SBMLMap SBMLid="S001__h2oM" COPASIkey="Metabolite_21"/>
    <SBMLMap SBMLid="S001__rbcM" COPASIkey="Metabolite_1"/>
    <SBMLMap SBMLid="S001__suc" COPASIkey="Metabolite_5"/>
    <SBMLMap SBMLid="UGALP_f" COPASIkey="ModelValue_106"/>
    <SBMLMap SBMLid="UGP_f" COPASIkey="ModelValue_105"/>
    <SBMLMap SBMLid="UGP_k_gal1p" COPASIkey="ModelValue_112"/>
    <SBMLMap SBMLid="UGP_k_glc1p" COPASIkey="ModelValue_109"/>
    <SBMLMap SBMLid="UGP_k_ppi" COPASIkey="ModelValue_111"/>
    <SBMLMap SBMLid="UGP_k_udpgal" COPASIkey="ModelValue_113"/>
    <SBMLMap SBMLid="UGP_k_udpglc" COPASIkey="ModelValue_110"/>
    <SBMLMap SBMLid="UGP_k_utp" COPASIkey="ModelValue_108"/>
    <SBMLMap SBMLid="UGP_keq" COPASIkey="ModelValue_107"/>
    <SBMLMap SBMLid="UGP_ki_udpglc" COPASIkey="ModelValue_115"/>
    <SBMLMap SBMLid="UGP_ki_utp" COPASIkey="ModelValue_114"/>
    <SBMLMap SBMLid="Vol_cell" COPASIkey="ModelValue_15"/>
    <SBMLMap SBMLid="Vol_dis" COPASIkey="ModelValue_14"/>
    <SBMLMap SBMLid="Vol_pp" COPASIkey="ModelValue_16"/>
    <SBMLMap SBMLid="Vol_pv" COPASIkey="ModelValue_17"/>
    <SBMLMap SBMLid="Vol_sin" COPASIkey="ModelValue_13"/>
    <SBMLMap SBMLid="deficiency" COPASIkey="ModelValue_45"/>
    <SBMLMap SBMLid="flow_sin" COPASIkey="ModelValue_4"/>
    <SBMLMap SBMLid="scale" COPASIkey="ModelValue_43"/>
    <SBMLMap SBMLid="scale_f" COPASIkey="ModelValue_42"/>
    <SBMLMap SBMLid="x_cell" COPASIkey="ModelValue_8"/>
    <SBMLMap SBMLid="x_sin" COPASIkey="ModelValue_9"/>
    <SBMLMap SBMLid="y_cell" COPASIkey="ModelValue_3"/>
    <SBMLMap SBMLid="y_dis" COPASIkey="ModelValue_2"/>
    <SBMLMap SBMLid="y_sin" COPASIkey="ModelValue_1"/>
  </SBMLReference>
</COPASI>
