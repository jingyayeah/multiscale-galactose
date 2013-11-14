<?xml version="1.0" encoding="UTF-8"?>
<!-- generated with COPASI 4.9.43 (Source) (http://www.copasi.org) at 2013-11-13 21:31:57 UTC -->
<?oxygen RNGSchema="http://www.copasi.org/static/schema/CopasiML.rng" type="xml"?>
<COPASI xmlns="http://www.copasi.org/static/schema" versionMajor="4" versionMinor="9" versionDevel="43" copasiSourcesModified="0">
  <ListOfFunctions>
    <Function key="Function_39" name="Function for FlowPPS001_rbcM" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*PP__rbcM*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_246" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_258" name="PP__rbcM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_265" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_40" name="Function for FlowS001S002_rbcM" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*S001__rbcM*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_269" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_270" name="S001__rbcM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_271" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_41" name="Function for FlowS002S003_rbcM" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*S002__rbcM*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_275" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_276" name="S002__rbcM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_277" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_42" name="Function for FlowS003S004_rbcM" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*S003__rbcM*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_281" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_282" name="S003__rbcM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_283" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_43" name="Function for FlowS004S005_rbcM" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*S004__rbcM*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_287" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_288" name="S004__rbcM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_289" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_44" name="Function for FlowS005PV_rbcM" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*S005__rbcM*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_293" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_294" name="S005__rbcM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_295" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_45" name="Function for FlowPVNULL_rbcM" type="UserDefined" reversible="true">
      <Expression>
        flow_sin*PV__rbcM*A_sin/PV
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_300" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_301" name="PV" order="1" role="volume"/>
        <ParameterDescription key="FunctionParameter_302" name="PV__rbcM" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_303" name="flow_sin" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_46" name="Function for FlowPPS001_suc" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*PP__suc*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_254" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_308" name="PP__suc" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_309" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_47" name="Function for FlowS001S002_suc" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*S001__suc*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_313" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_314" name="S001__suc" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_315" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_48" name="Function for FlowS002S003_suc" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*S002__suc*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_319" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_320" name="S002__suc" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_321" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_49" name="Function for FlowS003S004_suc" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*S003__suc*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_325" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_326" name="S003__suc" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_327" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_50" name="Function for FlowS004S005_suc" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*S004__suc*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_331" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_332" name="S004__suc" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_333" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_51" name="Function for FlowS005PV_suc" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*S005__suc*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_337" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_338" name="S005__suc" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_339" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_52" name="Function for FlowPVNULL_suc" type="UserDefined" reversible="true">
      <Expression>
        flow_sin*PV__suc*A_sin/PV
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_344" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_345" name="PV" order="1" role="volume"/>
        <ParameterDescription key="FunctionParameter_346" name="PV__suc" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_347" name="flow_sin" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_53" name="Function for FlowPPS001_alb" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*PP__alb*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_299" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_352" name="PP__alb" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_353" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_54" name="Function for FlowS001S002_alb" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*S001__alb*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_357" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_358" name="S001__alb" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_359" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_55" name="Function for FlowS002S003_alb" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*S002__alb*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_363" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_364" name="S002__alb" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_365" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_56" name="Function for FlowS003S004_alb" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*S003__alb*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_369" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_370" name="S003__alb" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_371" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_57" name="Function for FlowS004S005_alb" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*S004__alb*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_375" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_376" name="S004__alb" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_377" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_58" name="Function for FlowS005PV_alb" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*S005__alb*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_381" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_382" name="S005__alb" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_383" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_59" name="Function for FlowPVNULL_alb" type="UserDefined" reversible="true">
      <Expression>
        flow_sin*PV__alb*A_sin/PV
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_388" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_389" name="PV" order="1" role="volume"/>
        <ParameterDescription key="FunctionParameter_390" name="PV__alb" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_391" name="flow_sin" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_60" name="Function for FlowPPS001_gal" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*PP__gal*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_343" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_396" name="PP__gal" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_397" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_61" name="Function for FlowS001S002_gal" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*S001__gal*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_401" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_402" name="S001__gal" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_403" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_62" name="Function for FlowS002S003_gal" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*S002__gal*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_407" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_408" name="S002__gal" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_409" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_63" name="Function for FlowS003S004_gal" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*S003__gal*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_413" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_414" name="S003__gal" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_415" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_64" name="Function for FlowS004S005_gal" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*S004__gal*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_419" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_420" name="S004__gal" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_421" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_65" name="Function for FlowS005PV_gal" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*S005__gal*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_425" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_426" name="S005__gal" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_427" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_66" name="Function for FlowPVNULL_gal" type="UserDefined" reversible="true">
      <Expression>
        flow_sin*PV__gal*A_sin/PV
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_432" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_433" name="PV" order="1" role="volume"/>
        <ParameterDescription key="FunctionParameter_434" name="PV__gal" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_435" name="flow_sin" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_67" name="Function for FlowPPS001_galM" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*PP__galM*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_387" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_440" name="PP__galM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_441" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_68" name="Function for FlowS001S002_galM" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*S001__galM*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_445" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_446" name="S001__galM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_447" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_69" name="Function for FlowS002S003_galM" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*S002__galM*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_451" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_452" name="S002__galM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_453" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_70" name="Function for FlowS003S004_galM" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*S003__galM*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_457" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_458" name="S003__galM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_459" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_71" name="Function for FlowS004S005_galM" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*S004__galM*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_463" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_464" name="S004__galM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_465" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_72" name="Function for FlowS005PV_galM" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*S005__galM*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_469" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_470" name="S005__galM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_471" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_73" name="Function for FlowPVNULL_galM" type="UserDefined" reversible="true">
      <Expression>
        flow_sin*PV__galM*A_sin/PV
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_476" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_477" name="PV" order="1" role="volume"/>
        <ParameterDescription key="FunctionParameter_478" name="PV__galM" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_479" name="flow_sin" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_74" name="Function for FlowPPS001_h2oM" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*PP__h2oM*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_431" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_484" name="PP__h2oM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_485" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_75" name="Function for FlowS001S002_h2oM" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*S001__h2oM*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_489" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_490" name="S001__h2oM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_491" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_76" name="Function for FlowS002S003_h2oM" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*S002__h2oM*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_495" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_496" name="S002__h2oM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_497" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_77" name="Function for FlowS003S004_h2oM" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*S003__h2oM*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_501" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_502" name="S003__h2oM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_503" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_78" name="Function for FlowS004S005_h2oM" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*S004__h2oM*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_507" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_508" name="S004__h2oM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_509" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_79" name="Function for FlowS005PV_h2oM" type="UserDefined" reversible="unspecified">
      <Expression>
        flow_sin*S005__h2oM*A_sin
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_513" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_514" name="S005__h2oM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_515" name="flow_sin" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_80" name="Function for FlowPVNULL_h2oM" type="UserDefined" reversible="true">
      <Expression>
        flow_sin*PV__h2oM*A_sin/PV
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_520" name="A_sin" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_521" name="PV" order="1" role="volume"/>
        <ParameterDescription key="FunctionParameter_522" name="PV__h2oM" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_523" name="flow_sin" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_81" name="Function for DiffPPS001_rbcM" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_rbcM*(PP__rbcM-S001__rbcM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_475" name="Dx_sin_rbcM" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_528" name="PP__rbcM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_529" name="S001__rbcM" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_82" name="Function for DiffS001S002_rbcM" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_rbcM*(S001__rbcM-S002__rbcM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_533" name="Dx_sin_rbcM" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_534" name="S001__rbcM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_535" name="S002__rbcM" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_83" name="Function for DiffS002S003_rbcM" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_rbcM*(S002__rbcM-S003__rbcM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_539" name="Dx_sin_rbcM" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_540" name="S002__rbcM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_541" name="S003__rbcM" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_84" name="Function for DiffS003S004_rbcM" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_rbcM*(S003__rbcM-S004__rbcM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_545" name="Dx_sin_rbcM" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_546" name="S003__rbcM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_547" name="S004__rbcM" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_85" name="Function for DiffS004S005_rbcM" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_rbcM*(S004__rbcM-S005__rbcM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_551" name="Dx_sin_rbcM" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_552" name="S004__rbcM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_553" name="S005__rbcM" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_86" name="Function for DiffS005PV_rbcM" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_rbcM*(S005__rbcM-PV__rbcM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_557" name="Dx_sin_rbcM" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_558" name="PV__rbcM" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_559" name="S005__rbcM" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_87" name="Function for DiffD001D002_rbcM" type="UserDefined" reversible="true">
      <Expression>
        Dx_dis_rbcM*(D001__rbcM-D002__rbcM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_563" name="D001__rbcM" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_564" name="D002__rbcM" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_565" name="Dx_dis_rbcM" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_88" name="Function for DiffD002D003_rbcM" type="UserDefined" reversible="true">
      <Expression>
        Dx_dis_rbcM*(D002__rbcM-D003__rbcM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_569" name="D002__rbcM" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_570" name="D003__rbcM" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_571" name="Dx_dis_rbcM" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_89" name="Function for DiffD003D004_rbcM" type="UserDefined" reversible="true">
      <Expression>
        Dx_dis_rbcM*(D003__rbcM-D004__rbcM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_575" name="D003__rbcM" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_576" name="D004__rbcM" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_577" name="Dx_dis_rbcM" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_90" name="Function for DiffD004D005_rbcM" type="UserDefined" reversible="true">
      <Expression>
        Dx_dis_rbcM*(D004__rbcM-D005__rbcM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_581" name="D004__rbcM" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_582" name="D005__rbcM" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_583" name="Dx_dis_rbcM" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_91" name="Function for DiffS001D001_rbcM" type="UserDefined" reversible="true">
      <Expression>
        Dy_sindis_rbcM*(S001__rbcM-D001__rbcM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_587" name="D001__rbcM" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_588" name="Dy_sindis_rbcM" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_589" name="S001__rbcM" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_92" name="Function for DiffS002D002_rbcM" type="UserDefined" reversible="true">
      <Expression>
        Dy_sindis_rbcM*(S002__rbcM-D002__rbcM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_593" name="D002__rbcM" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_594" name="Dy_sindis_rbcM" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_595" name="S002__rbcM" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_93" name="Function for DiffS003D003_rbcM" type="UserDefined" reversible="true">
      <Expression>
        Dy_sindis_rbcM*(S003__rbcM-D003__rbcM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_599" name="D003__rbcM" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_600" name="Dy_sindis_rbcM" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_601" name="S003__rbcM" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_94" name="Function for DiffS004D004_rbcM" type="UserDefined" reversible="true">
      <Expression>
        Dy_sindis_rbcM*(S004__rbcM-D004__rbcM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_605" name="D004__rbcM" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_606" name="Dy_sindis_rbcM" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_607" name="S004__rbcM" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_95" name="Function for DiffS005D005_rbcM" type="UserDefined" reversible="true">
      <Expression>
        Dy_sindis_rbcM*(S005__rbcM-D005__rbcM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_611" name="D005__rbcM" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_612" name="Dy_sindis_rbcM" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_613" name="S005__rbcM" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_96" name="Function for DiffPPS001_suc" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_suc*(PP__suc-S001__suc)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_617" name="Dx_sin_suc" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_618" name="PP__suc" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_619" name="S001__suc" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_97" name="Function for DiffS001S002_suc" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_suc*(S001__suc-S002__suc)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_623" name="Dx_sin_suc" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_624" name="S001__suc" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_625" name="S002__suc" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_98" name="Function for DiffS002S003_suc" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_suc*(S002__suc-S003__suc)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_629" name="Dx_sin_suc" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_630" name="S002__suc" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_631" name="S003__suc" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_99" name="Function for DiffS003S004_suc" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_suc*(S003__suc-S004__suc)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_635" name="Dx_sin_suc" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_636" name="S003__suc" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_637" name="S004__suc" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_100" name="Function for DiffS004S005_suc" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_suc*(S004__suc-S005__suc)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_641" name="Dx_sin_suc" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_642" name="S004__suc" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_643" name="S005__suc" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_101" name="Function for DiffS005PV_suc" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_suc*(S005__suc-PV__suc)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_647" name="Dx_sin_suc" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_648" name="PV__suc" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_649" name="S005__suc" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_102" name="Function for DiffD001D002_suc" type="UserDefined" reversible="true">
      <Expression>
        Dx_dis_suc*(D001__suc-D002__suc)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_653" name="D001__suc" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_654" name="D002__suc" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_655" name="Dx_dis_suc" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_103" name="Function for DiffD002D003_suc" type="UserDefined" reversible="true">
      <Expression>
        Dx_dis_suc*(D002__suc-D003__suc)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_659" name="D002__suc" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_660" name="D003__suc" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_661" name="Dx_dis_suc" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_104" name="Function for DiffD003D004_suc" type="UserDefined" reversible="true">
      <Expression>
        Dx_dis_suc*(D003__suc-D004__suc)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_665" name="D003__suc" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_666" name="D004__suc" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_667" name="Dx_dis_suc" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_105" name="Function for DiffD004D005_suc" type="UserDefined" reversible="true">
      <Expression>
        Dx_dis_suc*(D004__suc-D005__suc)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_671" name="D004__suc" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_672" name="D005__suc" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_673" name="Dx_dis_suc" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_106" name="Function for DiffS001D001_suc" type="UserDefined" reversible="true">
      <Expression>
        Dy_sindis_suc*(S001__suc-D001__suc)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_677" name="D001__suc" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_678" name="Dy_sindis_suc" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_679" name="S001__suc" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_107" name="Function for DiffS002D002_suc" type="UserDefined" reversible="true">
      <Expression>
        Dy_sindis_suc*(S002__suc-D002__suc)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_683" name="D002__suc" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_684" name="Dy_sindis_suc" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_685" name="S002__suc" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_108" name="Function for DiffS003D003_suc" type="UserDefined" reversible="true">
      <Expression>
        Dy_sindis_suc*(S003__suc-D003__suc)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_689" name="D003__suc" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_690" name="Dy_sindis_suc" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_691" name="S003__suc" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_109" name="Function for DiffS004D004_suc" type="UserDefined" reversible="true">
      <Expression>
        Dy_sindis_suc*(S004__suc-D004__suc)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_695" name="D004__suc" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_696" name="Dy_sindis_suc" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_697" name="S004__suc" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_110" name="Function for DiffS005D005_suc" type="UserDefined" reversible="true">
      <Expression>
        Dy_sindis_suc*(S005__suc-D005__suc)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_701" name="D005__suc" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_702" name="Dy_sindis_suc" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_703" name="S005__suc" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_111" name="Function for DiffPPS001_alb" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_alb*(PP__alb-S001__alb)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_707" name="Dx_sin_alb" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_708" name="PP__alb" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_709" name="S001__alb" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_112" name="Function for DiffS001S002_alb" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_alb*(S001__alb-S002__alb)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_713" name="Dx_sin_alb" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_714" name="S001__alb" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_715" name="S002__alb" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_113" name="Function for DiffS002S003_alb" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_alb*(S002__alb-S003__alb)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_719" name="Dx_sin_alb" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_720" name="S002__alb" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_721" name="S003__alb" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_114" name="Function for DiffS003S004_alb" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_alb*(S003__alb-S004__alb)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_725" name="Dx_sin_alb" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_726" name="S003__alb" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_727" name="S004__alb" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_115" name="Function for DiffS004S005_alb" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_alb*(S004__alb-S005__alb)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_731" name="Dx_sin_alb" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_732" name="S004__alb" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_733" name="S005__alb" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_116" name="Function for DiffS005PV_alb" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_alb*(S005__alb-PV__alb)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_737" name="Dx_sin_alb" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_738" name="PV__alb" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_739" name="S005__alb" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_117" name="Function for DiffD001D002_alb" type="UserDefined" reversible="true">
      <Expression>
        Dx_dis_alb*(D001__alb-D002__alb)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_743" name="D001__alb" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_744" name="D002__alb" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_745" name="Dx_dis_alb" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_118" name="Function for DiffD002D003_alb" type="UserDefined" reversible="true">
      <Expression>
        Dx_dis_alb*(D002__alb-D003__alb)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_749" name="D002__alb" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_750" name="D003__alb" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_751" name="Dx_dis_alb" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_119" name="Function for DiffD003D004_alb" type="UserDefined" reversible="true">
      <Expression>
        Dx_dis_alb*(D003__alb-D004__alb)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_755" name="D003__alb" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_756" name="D004__alb" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_757" name="Dx_dis_alb" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_120" name="Function for DiffD004D005_alb" type="UserDefined" reversible="true">
      <Expression>
        Dx_dis_alb*(D004__alb-D005__alb)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_761" name="D004__alb" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_762" name="D005__alb" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_763" name="Dx_dis_alb" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_121" name="Function for DiffS001D001_alb" type="UserDefined" reversible="true">
      <Expression>
        Dy_sindis_alb*(S001__alb-D001__alb)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_767" name="D001__alb" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_768" name="Dy_sindis_alb" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_769" name="S001__alb" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_122" name="Function for DiffS002D002_alb" type="UserDefined" reversible="true">
      <Expression>
        Dy_sindis_alb*(S002__alb-D002__alb)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_773" name="D002__alb" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_774" name="Dy_sindis_alb" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_775" name="S002__alb" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_123" name="Function for DiffS003D003_alb" type="UserDefined" reversible="true">
      <Expression>
        Dy_sindis_alb*(S003__alb-D003__alb)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_779" name="D003__alb" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_780" name="Dy_sindis_alb" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_781" name="S003__alb" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_124" name="Function for DiffS004D004_alb" type="UserDefined" reversible="true">
      <Expression>
        Dy_sindis_alb*(S004__alb-D004__alb)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_785" name="D004__alb" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_786" name="Dy_sindis_alb" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_787" name="S004__alb" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_125" name="Function for DiffS005D005_alb" type="UserDefined" reversible="true">
      <Expression>
        Dy_sindis_alb*(S005__alb-D005__alb)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_791" name="D005__alb" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_792" name="Dy_sindis_alb" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_793" name="S005__alb" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_126" name="Function for DiffPPS001_gal" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_gal*(PP__gal-S001__gal)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_797" name="Dx_sin_gal" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_798" name="PP__gal" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_799" name="S001__gal" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_127" name="Function for DiffS001S002_gal" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_gal*(S001__gal-S002__gal)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_803" name="Dx_sin_gal" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_804" name="S001__gal" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_805" name="S002__gal" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_128" name="Function for DiffS002S003_gal" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_gal*(S002__gal-S003__gal)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_809" name="Dx_sin_gal" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_810" name="S002__gal" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_811" name="S003__gal" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_129" name="Function for DiffS003S004_gal" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_gal*(S003__gal-S004__gal)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_815" name="Dx_sin_gal" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_816" name="S003__gal" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_817" name="S004__gal" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_130" name="Function for DiffS004S005_gal" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_gal*(S004__gal-S005__gal)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_821" name="Dx_sin_gal" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_822" name="S004__gal" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_823" name="S005__gal" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_131" name="Function for DiffS005PV_gal" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_gal*(S005__gal-PV__gal)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_827" name="Dx_sin_gal" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_828" name="PV__gal" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_829" name="S005__gal" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_132" name="Function for DiffD001D002_gal" type="UserDefined" reversible="true">
      <Expression>
        Dx_dis_gal*(D001__gal-D002__gal)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_833" name="D001__gal" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_834" name="D002__gal" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_835" name="Dx_dis_gal" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_133" name="Function for DiffD002D003_gal" type="UserDefined" reversible="true">
      <Expression>
        Dx_dis_gal*(D002__gal-D003__gal)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_839" name="D002__gal" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_840" name="D003__gal" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_841" name="Dx_dis_gal" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_134" name="Function for DiffD003D004_gal" type="UserDefined" reversible="true">
      <Expression>
        Dx_dis_gal*(D003__gal-D004__gal)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_845" name="D003__gal" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_846" name="D004__gal" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_847" name="Dx_dis_gal" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_135" name="Function for DiffD004D005_gal" type="UserDefined" reversible="true">
      <Expression>
        Dx_dis_gal*(D004__gal-D005__gal)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_851" name="D004__gal" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_852" name="D005__gal" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_853" name="Dx_dis_gal" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_136" name="Function for DiffS001D001_gal" type="UserDefined" reversible="true">
      <Expression>
        Dy_sindis_gal*(S001__gal-D001__gal)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_857" name="D001__gal" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_858" name="Dy_sindis_gal" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_859" name="S001__gal" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_137" name="Function for DiffS002D002_gal" type="UserDefined" reversible="true">
      <Expression>
        Dy_sindis_gal*(S002__gal-D002__gal)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_863" name="D002__gal" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_864" name="Dy_sindis_gal" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_865" name="S002__gal" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_138" name="Function for DiffS003D003_gal" type="UserDefined" reversible="true">
      <Expression>
        Dy_sindis_gal*(S003__gal-D003__gal)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_869" name="D003__gal" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_870" name="Dy_sindis_gal" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_871" name="S003__gal" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_139" name="Function for DiffS004D004_gal" type="UserDefined" reversible="true">
      <Expression>
        Dy_sindis_gal*(S004__gal-D004__gal)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_875" name="D004__gal" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_876" name="Dy_sindis_gal" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_877" name="S004__gal" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_140" name="Function for DiffS005D005_gal" type="UserDefined" reversible="true">
      <Expression>
        Dy_sindis_gal*(S005__gal-D005__gal)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_881" name="D005__gal" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_882" name="Dy_sindis_gal" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_883" name="S005__gal" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_141" name="Function for DiffPPS001_galM" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_galM*(PP__galM-S001__galM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_887" name="Dx_sin_galM" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_888" name="PP__galM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_889" name="S001__galM" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_142" name="Function for DiffS001S002_galM" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_galM*(S001__galM-S002__galM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_893" name="Dx_sin_galM" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_894" name="S001__galM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_895" name="S002__galM" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_143" name="Function for DiffS002S003_galM" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_galM*(S002__galM-S003__galM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_899" name="Dx_sin_galM" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_900" name="S002__galM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_901" name="S003__galM" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_144" name="Function for DiffS003S004_galM" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_galM*(S003__galM-S004__galM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_905" name="Dx_sin_galM" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_906" name="S003__galM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_907" name="S004__galM" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_145" name="Function for DiffS004S005_galM" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_galM*(S004__galM-S005__galM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_911" name="Dx_sin_galM" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_912" name="S004__galM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_913" name="S005__galM" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_146" name="Function for DiffS005PV_galM" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_galM*(S005__galM-PV__galM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_917" name="Dx_sin_galM" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_918" name="PV__galM" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_919" name="S005__galM" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_147" name="Function for DiffD001D002_galM" type="UserDefined" reversible="true">
      <Expression>
        Dx_dis_galM*(D001__galM-D002__galM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_923" name="D001__galM" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_924" name="D002__galM" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_925" name="Dx_dis_galM" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_148" name="Function for DiffD002D003_galM" type="UserDefined" reversible="true">
      <Expression>
        Dx_dis_galM*(D002__galM-D003__galM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_929" name="D002__galM" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_930" name="D003__galM" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_931" name="Dx_dis_galM" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_149" name="Function for DiffD003D004_galM" type="UserDefined" reversible="true">
      <Expression>
        Dx_dis_galM*(D003__galM-D004__galM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_935" name="D003__galM" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_936" name="D004__galM" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_937" name="Dx_dis_galM" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_150" name="Function for DiffD004D005_galM" type="UserDefined" reversible="true">
      <Expression>
        Dx_dis_galM*(D004__galM-D005__galM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_941" name="D004__galM" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_942" name="D005__galM" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_943" name="Dx_dis_galM" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_151" name="Function for DiffS001D001_galM" type="UserDefined" reversible="true">
      <Expression>
        Dy_sindis_galM*(S001__galM-D001__galM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_947" name="D001__galM" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_948" name="Dy_sindis_galM" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_949" name="S001__galM" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_152" name="Function for DiffS002D002_galM" type="UserDefined" reversible="true">
      <Expression>
        Dy_sindis_galM*(S002__galM-D002__galM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_953" name="D002__galM" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_954" name="Dy_sindis_galM" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_955" name="S002__galM" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_153" name="Function for DiffS003D003_galM" type="UserDefined" reversible="true">
      <Expression>
        Dy_sindis_galM*(S003__galM-D003__galM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_959" name="D003__galM" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_960" name="Dy_sindis_galM" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_961" name="S003__galM" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_154" name="Function for DiffS004D004_galM" type="UserDefined" reversible="true">
      <Expression>
        Dy_sindis_galM*(S004__galM-D004__galM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_965" name="D004__galM" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_966" name="Dy_sindis_galM" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_967" name="S004__galM" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_155" name="Function for DiffS005D005_galM" type="UserDefined" reversible="true">
      <Expression>
        Dy_sindis_galM*(S005__galM-D005__galM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_971" name="D005__galM" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_972" name="Dy_sindis_galM" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_973" name="S005__galM" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_156" name="Function for DiffPPS001_h2oM" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_h2oM*(PP__h2oM-S001__h2oM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_977" name="Dx_sin_h2oM" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_978" name="PP__h2oM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_979" name="S001__h2oM" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_157" name="Function for DiffS001S002_h2oM" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_h2oM*(S001__h2oM-S002__h2oM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_983" name="Dx_sin_h2oM" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_984" name="S001__h2oM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_985" name="S002__h2oM" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_158" name="Function for DiffS002S003_h2oM" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_h2oM*(S002__h2oM-S003__h2oM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_989" name="Dx_sin_h2oM" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_990" name="S002__h2oM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_991" name="S003__h2oM" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_159" name="Function for DiffS003S004_h2oM" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_h2oM*(S003__h2oM-S004__h2oM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_995" name="Dx_sin_h2oM" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_996" name="S003__h2oM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_997" name="S004__h2oM" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_160" name="Function for DiffS004S005_h2oM" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_h2oM*(S004__h2oM-S005__h2oM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_1001" name="Dx_sin_h2oM" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_1002" name="S004__h2oM" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_1003" name="S005__h2oM" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_161" name="Function for DiffS005PV_h2oM" type="UserDefined" reversible="true">
      <Expression>
        Dx_sin_h2oM*(S005__h2oM-PV__h2oM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_1007" name="Dx_sin_h2oM" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_1008" name="PV__h2oM" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_1009" name="S005__h2oM" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_162" name="Function for DiffD001D002_h2oM" type="UserDefined" reversible="true">
      <Expression>
        Dx_dis_h2oM*(D001__h2oM-D002__h2oM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_1013" name="D001__h2oM" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_1014" name="D002__h2oM" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_1015" name="Dx_dis_h2oM" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_163" name="Function for DiffD002D003_h2oM" type="UserDefined" reversible="true">
      <Expression>
        Dx_dis_h2oM*(D002__h2oM-D003__h2oM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_1019" name="D002__h2oM" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_1020" name="D003__h2oM" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_1021" name="Dx_dis_h2oM" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_164" name="Function for DiffD003D004_h2oM" type="UserDefined" reversible="true">
      <Expression>
        Dx_dis_h2oM*(D003__h2oM-D004__h2oM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_1025" name="D003__h2oM" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_1026" name="D004__h2oM" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_1027" name="Dx_dis_h2oM" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_165" name="Function for DiffD004D005_h2oM" type="UserDefined" reversible="true">
      <Expression>
        Dx_dis_h2oM*(D004__h2oM-D005__h2oM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_1031" name="D004__h2oM" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_1032" name="D005__h2oM" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_1033" name="Dx_dis_h2oM" order="2" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_166" name="Function for DiffS001D001_h2oM" type="UserDefined" reversible="true">
      <Expression>
        Dy_sindis_h2oM*(S001__h2oM-D001__h2oM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_1037" name="D001__h2oM" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_1038" name="Dy_sindis_h2oM" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_1039" name="S001__h2oM" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_167" name="Function for DiffS002D002_h2oM" type="UserDefined" reversible="true">
      <Expression>
        Dy_sindis_h2oM*(S002__h2oM-D002__h2oM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_1043" name="D002__h2oM" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_1044" name="Dy_sindis_h2oM" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_1045" name="S002__h2oM" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_168" name="Function for DiffS003D003_h2oM" type="UserDefined" reversible="true">
      <Expression>
        Dy_sindis_h2oM*(S003__h2oM-D003__h2oM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_1049" name="D003__h2oM" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_1050" name="Dy_sindis_h2oM" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_1051" name="S003__h2oM" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_169" name="Function for DiffS004D004_h2oM" type="UserDefined" reversible="true">
      <Expression>
        Dy_sindis_h2oM*(S004__h2oM-D004__h2oM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_1055" name="D004__h2oM" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_1056" name="Dy_sindis_h2oM" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_1057" name="S004__h2oM" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_170" name="Function for DiffS005D005_h2oM" type="UserDefined" reversible="true">
      <Expression>
        Dy_sindis_h2oM*(S005__h2oM-D005__h2oM)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_1061" name="D005__h2oM" order="0" role="product"/>
        <ParameterDescription key="FunctionParameter_1062" name="Dy_sindis_h2oM" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_1063" name="S005__h2oM" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_171" name="Function for Galactokinase (H01)" type="UserDefined" reversible="true">
      <Expression>
        H01__GALK_Vmax/(GALK_k_gal*GALK_k_atp)*1/(1+H01__gal1p/GALK_ki_gal1p)*(H01__gal*H01__atp-H01__gal1p*H01__adp/GALK_keq)/H01__GALK_dm/H01
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_1075" name="GALK_k_atp" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_1076" name="GALK_k_gal" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_1077" name="GALK_keq" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_1078" name="GALK_ki_gal1p" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_1079" name="H01" order="4" role="volume"/>
        <ParameterDescription key="FunctionParameter_1080" name="H01__GALK_Vmax" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_1081" name="H01__GALK_dm" order="6" role="constant"/>
        <ParameterDescription key="FunctionParameter_1082" name="H01__adp" order="7" role="product"/>
        <ParameterDescription key="FunctionParameter_1083" name="H01__atp" order="8" role="substrate"/>
        <ParameterDescription key="FunctionParameter_1084" name="H01__gal" order="9" role="substrate"/>
        <ParameterDescription key="FunctionParameter_1085" name="H01__gal1p" order="10" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_172" name="Function for Galactokinase (H01)_2" type="UserDefined" reversible="false">
      <Expression>
        H01__GALK_Vmax/(GALK_k_gal*GALK_k_atp)*1/(1+H01__gal1p/GALK_ki_gal1p)*H01__galM*H01__atp/H01__GALK_dm/H01
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_262" name="GALK_k_atp" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_519" name="GALK_k_gal" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_1097" name="GALK_ki_gal1p" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_1098" name="H01" order="3" role="volume"/>
        <ParameterDescription key="FunctionParameter_1099" name="H01__GALK_Vmax" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_1100" name="H01__GALK_dm" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_1101" name="H01__atp" order="6" role="substrate"/>
        <ParameterDescription key="FunctionParameter_1102" name="H01__gal1p" order="7" role="product"/>
        <ParameterDescription key="FunctionParameter_1103" name="H01__galM" order="8" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_173" name="Function for Inositol monophosphatase (H01)" type="UserDefined" reversible="false">
      <Expression>
        H01__IMP_Vmax/IMP_k_gal1p*H01__gal1p/(1+H01__gal1p/IMP_k_gal1p)/H01
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_1067" name="H01" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_1072" name="H01__IMP_Vmax" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_1073" name="H01__gal1p" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_1069" name="IMP_k_gal1p" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_174" name="Function for ATP synthase (H01)" type="UserDefined" reversible="true">
      <Expression>
        H01__ATPS_Vmax/(ATPS_k_adp*ATPS_k_phos)*(H01__adp*H01__phos-H01__atp/ATPS_keq)/((1+H01__adp/ATPS_k_adp)*(1+H01__phos/ATPS_k_phos)+H01__atp/ATPS_k_atp)/H01
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_1121" name="ATPS_k_adp" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_1122" name="ATPS_k_atp" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_1123" name="ATPS_k_phos" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_1124" name="ATPS_keq" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_1125" name="H01" order="4" role="volume"/>
        <ParameterDescription key="FunctionParameter_1126" name="H01__ATPS_Vmax" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_1127" name="H01__adp" order="6" role="substrate"/>
        <ParameterDescription key="FunctionParameter_1128" name="H01__atp" order="7" role="product"/>
        <ParameterDescription key="FunctionParameter_1129" name="H01__phos" order="8" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_175" name="Function for Aldose reductase (H01)" type="UserDefined" reversible="true">
      <Expression>
        H01__ALDR_Vmax/(ALDR_k_gal*ALDR_k_nadp)*(H01__gal*H01__nadph-H01__galtol*H01__nadp/ALDR_keq)/((1+H01__gal/ALDR_k_gal)*(1+H01__nadph/ALDR_k_nadph)+(1+H01__galtol/ALDR_k_galtol)*(1+H01__nadp/ALDR_k_nadp)-1)/H01
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_1141" name="ALDR_k_gal" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_1142" name="ALDR_k_galtol" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_1143" name="ALDR_k_nadp" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_1144" name="ALDR_k_nadph" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_1145" name="ALDR_keq" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_1146" name="H01" order="5" role="volume"/>
        <ParameterDescription key="FunctionParameter_1147" name="H01__ALDR_Vmax" order="6" role="constant"/>
        <ParameterDescription key="FunctionParameter_1148" name="H01__gal" order="7" role="substrate"/>
        <ParameterDescription key="FunctionParameter_1149" name="H01__galtol" order="8" role="product"/>
        <ParameterDescription key="FunctionParameter_1150" name="H01__nadp" order="9" role="product"/>
        <ParameterDescription key="FunctionParameter_1151" name="H01__nadph" order="10" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_176" name="Function for NADP Reductase (H01)" type="UserDefined" reversible="false">
      <Expression>
        H01__NADPR_Vmax/NADPR_k_nadp*(H01__nadp-H01__nadph/NADPR_keq)/(1+H01__nadp/NADPR_k_nadp+H01__nadph/NADPR_ki_nadph)/H01
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_1074" name="H01" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_1068" name="H01__NADPR_Vmax" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_1139" name="H01__nadp" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_1117" name="H01__nadph" order="3" role="product"/>
        <ParameterDescription key="FunctionParameter_1163" name="NADPR_k_nadp" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_1164" name="NADPR_keq" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_1165" name="NADPR_ki_nadph" order="6" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_177" name="Function for Galactose-1-phosphate uridyl transferase (H01)" type="UserDefined" reversible="true">
      <Expression>
        H01__GALT_Vmax/(GALT_k_gal1p*GALT_k_udpglc)*(H01__gal1p*H01__udpglc-H01__glc1p*H01__udpgal/GALT_keq)/((1+H01__gal1p/GALT_k_gal1p)*(1+H01__udpglc/GALT_k_udpglc+H01__udp/GALT_ki_udp+H01__utp/GALT_ki_utp)+(1+H01__glc1p/GALT_k_glc1p)*(1+H01__udpgal/GALT_k_udpgal)-1)/H01
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_1181" name="GALT_k_gal1p" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_1182" name="GALT_k_glc1p" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_1183" name="GALT_k_udpgal" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_1184" name="GALT_k_udpglc" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_1185" name="GALT_keq" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_1186" name="GALT_ki_udp" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_1187" name="GALT_ki_utp" order="6" role="constant"/>
        <ParameterDescription key="FunctionParameter_1188" name="H01" order="7" role="volume"/>
        <ParameterDescription key="FunctionParameter_1189" name="H01__GALT_Vmax" order="8" role="constant"/>
        <ParameterDescription key="FunctionParameter_1190" name="H01__gal1p" order="9" role="substrate"/>
        <ParameterDescription key="FunctionParameter_1191" name="H01__glc1p" order="10" role="product"/>
        <ParameterDescription key="FunctionParameter_1192" name="H01__udp" order="11" role="modifier"/>
        <ParameterDescription key="FunctionParameter_1193" name="H01__udpgal" order="12" role="product"/>
        <ParameterDescription key="FunctionParameter_1194" name="H01__udpglc" order="13" role="substrate"/>
        <ParameterDescription key="FunctionParameter_1195" name="H01__utp" order="14" role="modifier"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_178" name="Function for UDP-glucose 4-epimerase (H01)" type="UserDefined" reversible="true">
      <Expression>
        H01__GALE_Vmax/GALE_k_udpglc*(H01__udpglc-H01__udpgal/GALE_keq)/(1+H01__udpglc/GALE_k_udpglc+H01__udpgal/GALE_k_udpgal)/H01
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_1180" name="GALE_k_udpgal" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_1177" name="GALE_k_udpglc" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_1175" name="GALE_keq" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_1173" name="H01" order="3" role="volume"/>
        <ParameterDescription key="FunctionParameter_264" name="H01__GALE_Vmax" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_1179" name="H01__udpgal" order="5" role="product"/>
        <ParameterDescription key="FunctionParameter_1178" name="H01__udpglc" order="6" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_179" name="Function for UDP-glucose pyrophosphorylase (H01)" type="UserDefined" reversible="true">
      <Expression>
        H01__UGP_Vmax/(UGP_k_utp*UGP_k_glc1p)*(H01__glc1p*H01__utp-H01__udpglc*H01__ppi/UGP_keq)/H01__UGP_dm/H01
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_1220" name="H01" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_1221" name="H01__UGP_Vmax" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_1222" name="H01__UGP_dm" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_1223" name="H01__glc1p" order="3" role="substrate"/>
        <ParameterDescription key="FunctionParameter_1224" name="H01__ppi" order="4" role="product"/>
        <ParameterDescription key="FunctionParameter_1225" name="H01__udpglc" order="5" role="product"/>
        <ParameterDescription key="FunctionParameter_1226" name="H01__utp" order="6" role="substrate"/>
        <ParameterDescription key="FunctionParameter_1227" name="UGP_k_glc1p" order="7" role="constant"/>
        <ParameterDescription key="FunctionParameter_1228" name="UGP_k_utp" order="8" role="constant"/>
        <ParameterDescription key="FunctionParameter_1229" name="UGP_keq" order="9" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_180" name="Function for UDP-galactose pyrophosphorylase (H01)" type="UserDefined" reversible="true">
      <Expression>
        UGALP_f*H01__UGP_Vmax/(UGP_k_utp*UGP_k_gal1p)*(H01__gal1p*H01__utp-H01__udpgal*H01__ppi/UGP_keq)/H01__UGP_dm/H01
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_1241" name="H01" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_1242" name="H01__UGP_Vmax" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_1243" name="H01__UGP_dm" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_1244" name="H01__gal1p" order="3" role="substrate"/>
        <ParameterDescription key="FunctionParameter_1245" name="H01__ppi" order="4" role="product"/>
        <ParameterDescription key="FunctionParameter_1246" name="H01__udpgal" order="5" role="product"/>
        <ParameterDescription key="FunctionParameter_1247" name="H01__utp" order="6" role="substrate"/>
        <ParameterDescription key="FunctionParameter_1248" name="UGALP_f" order="7" role="constant"/>
        <ParameterDescription key="FunctionParameter_1249" name="UGP_k_gal1p" order="8" role="constant"/>
        <ParameterDescription key="FunctionParameter_1250" name="UGP_k_utp" order="9" role="constant"/>
        <ParameterDescription key="FunctionParameter_1251" name="UGP_keq" order="10" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_181" name="Function for Pyrophosphatase (H01)" type="UserDefined" reversible="false">
      <Expression>
        H01__PPASE_Vmax*H01__ppi^PPASE_n/(H01__ppi^PPASE_n+PPASE_k_ppi^PPASE_n)/H01
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_1140" name="H01" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_1218" name="H01__PPASE_Vmax" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_1118" name="H01__ppi" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_1219" name="PPASE_k_ppi" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_1174" name="PPASE_n" order="4" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_182" name="Function for ATP:UDP phosphotransferase (H01)" type="UserDefined" reversible="true">
      <Expression>
        H01__NDKU_Vmax/NDKU_k_atp/NDKU_k_udp*(H01__atp*H01__udp-H01__adp*H01__utp/NDKU_keq)/((1+H01__atp/NDKU_k_atp)*(1+H01__udp/NDKU_k_udp)+(1+H01__adp/NDKU_k_adp)*(1+H01__utp/NDKU_k_utp)-1)/H01
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_1273" name="H01" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_1274" name="H01__NDKU_Vmax" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_1275" name="H01__adp" order="2" role="product"/>
        <ParameterDescription key="FunctionParameter_1276" name="H01__atp" order="3" role="substrate"/>
        <ParameterDescription key="FunctionParameter_1277" name="H01__udp" order="4" role="substrate"/>
        <ParameterDescription key="FunctionParameter_1278" name="H01__utp" order="5" role="product"/>
        <ParameterDescription key="FunctionParameter_1279" name="NDKU_k_adp" order="6" role="constant"/>
        <ParameterDescription key="FunctionParameter_1280" name="NDKU_k_atp" order="7" role="constant"/>
        <ParameterDescription key="FunctionParameter_1281" name="NDKU_k_udp" order="8" role="constant"/>
        <ParameterDescription key="FunctionParameter_1282" name="NDKU_k_utp" order="9" role="constant"/>
        <ParameterDescription key="FunctionParameter_1283" name="NDKU_keq" order="10" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_183" name="Function for Phosphoglucomutase-1 (H01)" type="UserDefined" reversible="true">
      <Expression>
        H01__PGM1_Vmax/PGM1_k_glc1p*(H01__glc1p-H01__glc6p/PGM1_keq)/(1+H01__glc1p/PGM1_k_glc1p+H01__glc6p/PGM1_k_glc6p)/H01
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_1119" name="H01" order="0" role="volume"/>
        <ParameterDescription key="FunctionParameter_1267" name="H01__PGM1_Vmax" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_1120" name="H01__glc1p" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_1272" name="H01__glc6p" order="3" role="product"/>
        <ParameterDescription key="FunctionParameter_1295" name="PGM1_k_glc1p" order="4" role="constant"/>
        <ParameterDescription key="FunctionParameter_1296" name="PGM1_k_glc6p" order="5" role="constant"/>
        <ParameterDescription key="FunctionParameter_1297" name="PGM1_keq" order="6" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_184" name="Function for Glycolysis (H01)" type="UserDefined" reversible="true">
      <Expression>
        H01__GLY_Vmax*(H01__glc6p-GLY_k_glc6p)/GLY_k_glc6p*H01__phos/(H01__phos+GLY_k_p)/H01
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_1071" name="GLY_k_glc6p" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_1305" name="GLY_k_p" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_1306" name="H01" order="2" role="volume"/>
        <ParameterDescription key="FunctionParameter_1307" name="H01__GLY_Vmax" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_1308" name="H01__glc6p" order="4" role="substrate"/>
        <ParameterDescription key="FunctionParameter_1309" name="H01__phos" order="5" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_185" name="Function for Glycosyltransferase galactose (H01)" type="UserDefined" reversible="false">
      <Expression>
        H01__GTF_Vmax*H01__udpgal/(H01__udpgal+GTF_k_udpgal)/H01
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_1176" name="GTF_k_udpgal" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_1271" name="H01" order="1" role="volume"/>
        <ParameterDescription key="FunctionParameter_1316" name="H01__GTF_Vmax" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_1317" name="H01__udpgal" order="3" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_186" name="Function for Glycosyltransferase glucose (H01)" type="UserDefined" reversible="false">
      <Expression>
        0*H01__GTF_Vmax*H01__udpglc/(H01__udpglc+GTF_k_udpglc)/H01
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_1322" name="GTF_k_udpglc" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_1323" name="H01" order="1" role="volume"/>
        <ParameterDescription key="FunctionParameter_1324" name="H01__GTF_Vmax" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_1325" name="H01__udpglc" order="3" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_187" name="Function for galactose transport" type="UserDefined" reversible="true">
      <Expression>
        H01__GLUT2_Vmax/(GLUT2_k_gal*Nf)*(D001__gal-H01__gal)/H01__GLUT2_dm
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_1332" name="D001__gal" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_1333" name="GLUT2_k_gal" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_1334" name="H01__GLUT2_Vmax" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_1335" name="H01__GLUT2_dm" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_1336" name="H01__gal" order="4" role="product"/>
        <ParameterDescription key="FunctionParameter_1337" name="Nf" order="5" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_188" name="Function for galactose transport_2" type="UserDefined" reversible="true">
      <Expression>
        H01__GLUT2_Vmax/(GLUT2_k_gal*Nf)*(D001__galM-H01__galM)/H01__GLUT2_dm
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_1344" name="D001__galM" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_1345" name="GLUT2_k_gal" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_1346" name="H01__GLUT2_Vmax" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_1347" name="H01__GLUT2_dm" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_1348" name="H01__galM" order="4" role="product"/>
        <ParameterDescription key="FunctionParameter_1349" name="Nf" order="5" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_189" name="Function for galactose transport_3" type="UserDefined" reversible="true">
      <Expression>
        H01__GLUT2_Vmax/(GLUT2_k_gal*Nf)*(D002__gal-H01__gal)/H01__GLUT2_dm
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_1356" name="D002__gal" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_1357" name="GLUT2_k_gal" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_1358" name="H01__GLUT2_Vmax" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_1359" name="H01__GLUT2_dm" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_1360" name="H01__gal" order="4" role="product"/>
        <ParameterDescription key="FunctionParameter_1361" name="Nf" order="5" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_190" name="Function for galactose transport_4" type="UserDefined" reversible="true">
      <Expression>
        H01__GLUT2_Vmax/(GLUT2_k_gal*Nf)*(D002__galM-H01__galM)/H01__GLUT2_dm
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_1368" name="D002__galM" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_1369" name="GLUT2_k_gal" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_1370" name="H01__GLUT2_Vmax" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_1371" name="H01__GLUT2_dm" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_1372" name="H01__galM" order="4" role="product"/>
        <ParameterDescription key="FunctionParameter_1373" name="Nf" order="5" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_191" name="Function for galactose transport_5" type="UserDefined" reversible="true">
      <Expression>
        H01__GLUT2_Vmax/(GLUT2_k_gal*Nf)*(D003__gal-H01__gal)/H01__GLUT2_dm
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_1380" name="D003__gal" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_1381" name="GLUT2_k_gal" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_1382" name="H01__GLUT2_Vmax" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_1383" name="H01__GLUT2_dm" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_1384" name="H01__gal" order="4" role="product"/>
        <ParameterDescription key="FunctionParameter_1385" name="Nf" order="5" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_192" name="Function for galactose transport_6" type="UserDefined" reversible="true">
      <Expression>
        H01__GLUT2_Vmax/(GLUT2_k_gal*Nf)*(D003__galM-H01__galM)/H01__GLUT2_dm
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_1392" name="D003__galM" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_1393" name="GLUT2_k_gal" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_1394" name="H01__GLUT2_Vmax" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_1395" name="H01__GLUT2_dm" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_1396" name="H01__galM" order="4" role="product"/>
        <ParameterDescription key="FunctionParameter_1397" name="Nf" order="5" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_193" name="Function for galactose transport_7" type="UserDefined" reversible="true">
      <Expression>
        H01__GLUT2_Vmax/(GLUT2_k_gal*Nf)*(D004__gal-H01__gal)/H01__GLUT2_dm
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_1404" name="D004__gal" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_1405" name="GLUT2_k_gal" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_1406" name="H01__GLUT2_Vmax" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_1407" name="H01__GLUT2_dm" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_1408" name="H01__gal" order="4" role="product"/>
        <ParameterDescription key="FunctionParameter_1409" name="Nf" order="5" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_194" name="Function for galactose transport_8" type="UserDefined" reversible="true">
      <Expression>
        H01__GLUT2_Vmax/(GLUT2_k_gal*Nf)*(D004__galM-H01__galM)/H01__GLUT2_dm
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_1416" name="D004__galM" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_1417" name="GLUT2_k_gal" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_1418" name="H01__GLUT2_Vmax" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_1419" name="H01__GLUT2_dm" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_1420" name="H01__galM" order="4" role="product"/>
        <ParameterDescription key="FunctionParameter_1421" name="Nf" order="5" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_195" name="Function for galactose transport_9" type="UserDefined" reversible="true">
      <Expression>
        H01__GLUT2_Vmax/(GLUT2_k_gal*Nf)*(D005__gal-H01__gal)/H01__GLUT2_dm
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_1428" name="D005__gal" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_1429" name="GLUT2_k_gal" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_1430" name="H01__GLUT2_Vmax" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_1431" name="H01__GLUT2_dm" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_1432" name="H01__gal" order="4" role="product"/>
        <ParameterDescription key="FunctionParameter_1433" name="Nf" order="5" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_196" name="Function for galactose transport_10" type="UserDefined" reversible="true">
      <Expression>
        H01__GLUT2_Vmax/(GLUT2_k_gal*Nf)*(D005__galM-H01__galM)/H01__GLUT2_dm
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_1440" name="D005__galM" order="0" role="substrate"/>
        <ParameterDescription key="FunctionParameter_1441" name="GLUT2_k_gal" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_1442" name="H01__GLUT2_Vmax" order="2" role="constant"/>
        <ParameterDescription key="FunctionParameter_1443" name="H01__GLUT2_dm" order="3" role="constant"/>
        <ParameterDescription key="FunctionParameter_1444" name="H01__galM" order="4" role="product"/>
        <ParameterDescription key="FunctionParameter_1445" name="Nf" order="5" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
  </ListOfFunctions>
  <Model key="Model_3" name="NoName" simulationType="time" timeUnit="s" volumeUnit="m³" areaUnit="m²" lengthUnit="m" quantityUnit="mol" type="deterministic" avogadroConstant="6.02214179e+23">
    <ListOfCompartments>
      <Compartment key="Compartment_1" name="PP" simulationType="assignment" dimensionality="3">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[Vol_pp],Reference=Value&gt;
        </Expression>
      </Compartment>
      <Compartment key="Compartment_3" name="S001" simulationType="assignment" dimensionality="3">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[Vol_sin],Reference=Value&gt;
        </Expression>
      </Compartment>
      <Compartment key="Compartment_5" name="D001" simulationType="assignment" dimensionality="3">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[Vol_dis],Reference=Value&gt;
        </Expression>
      </Compartment>
      <Compartment key="Compartment_7" name="S002" simulationType="assignment" dimensionality="3">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[Vol_sin],Reference=Value&gt;
        </Expression>
      </Compartment>
      <Compartment key="Compartment_9" name="D002" simulationType="assignment" dimensionality="3">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[Vol_dis],Reference=Value&gt;
        </Expression>
      </Compartment>
      <Compartment key="Compartment_11" name="S003" simulationType="assignment" dimensionality="3">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[Vol_sin],Reference=Value&gt;
        </Expression>
      </Compartment>
      <Compartment key="Compartment_13" name="D003" simulationType="assignment" dimensionality="3">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[Vol_dis],Reference=Value&gt;
        </Expression>
      </Compartment>
      <Compartment key="Compartment_15" name="S004" simulationType="assignment" dimensionality="3">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[Vol_sin],Reference=Value&gt;
        </Expression>
      </Compartment>
      <Compartment key="Compartment_17" name="D004" simulationType="assignment" dimensionality="3">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[Vol_dis],Reference=Value&gt;
        </Expression>
      </Compartment>
      <Compartment key="Compartment_19" name="S005" simulationType="assignment" dimensionality="3">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[Vol_sin],Reference=Value&gt;
        </Expression>
      </Compartment>
      <Compartment key="Compartment_21" name="D005" simulationType="assignment" dimensionality="3">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[Vol_dis],Reference=Value&gt;
        </Expression>
      </Compartment>
      <Compartment key="Compartment_23" name="PV" simulationType="assignment" dimensionality="3">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[Vol_pv],Reference=Value&gt;
        </Expression>
      </Compartment>
      <Compartment key="Compartment_25" name="H01" simulationType="assignment" dimensionality="3">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Values[Vol_cell],Reference=Value&gt;
        </Expression>
      </Compartment>
    </ListOfCompartments>
    <ListOfMetabolites>
      <Metabolite key="Metabolite_1" name="rbcM" simulationType="fixed" compartment="Compartment_1">
      </Metabolite>
      <Metabolite key="Metabolite_25" name="suc" simulationType="fixed" compartment="Compartment_1">
      </Metabolite>
      <Metabolite key="Metabolite_49" name="alb" simulationType="fixed" compartment="Compartment_1">
      </Metabolite>
      <Metabolite key="Metabolite_73" name="gal" simulationType="fixed" compartment="Compartment_1">
      </Metabolite>
      <Metabolite key="Metabolite_97" name="galM" simulationType="fixed" compartment="Compartment_1">
      </Metabolite>
      <Metabolite key="Metabolite_121" name="h2oM" simulationType="fixed" compartment="Compartment_1">
      </Metabolite>
      <Metabolite key="Metabolite_3" name="rbcM" simulationType="reactions" compartment="Compartment_3">
      </Metabolite>
      <Metabolite key="Metabolite_27" name="suc" simulationType="reactions" compartment="Compartment_3">
      </Metabolite>
      <Metabolite key="Metabolite_51" name="alb" simulationType="reactions" compartment="Compartment_3">
      </Metabolite>
      <Metabolite key="Metabolite_75" name="gal" simulationType="reactions" compartment="Compartment_3">
      </Metabolite>
      <Metabolite key="Metabolite_99" name="galM" simulationType="reactions" compartment="Compartment_3">
      </Metabolite>
      <Metabolite key="Metabolite_123" name="h2oM" simulationType="reactions" compartment="Compartment_3">
      </Metabolite>
      <Metabolite key="Metabolite_5" name="rbcM" simulationType="reactions" compartment="Compartment_5">
      </Metabolite>
      <Metabolite key="Metabolite_29" name="suc" simulationType="reactions" compartment="Compartment_5">
      </Metabolite>
      <Metabolite key="Metabolite_53" name="alb" simulationType="reactions" compartment="Compartment_5">
      </Metabolite>
      <Metabolite key="Metabolite_77" name="gal" simulationType="reactions" compartment="Compartment_5">
      </Metabolite>
      <Metabolite key="Metabolite_101" name="galM" simulationType="reactions" compartment="Compartment_5">
      </Metabolite>
      <Metabolite key="Metabolite_125" name="h2oM" simulationType="reactions" compartment="Compartment_5">
      </Metabolite>
      <Metabolite key="Metabolite_7" name="rbcM" simulationType="reactions" compartment="Compartment_7">
      </Metabolite>
      <Metabolite key="Metabolite_31" name="suc" simulationType="reactions" compartment="Compartment_7">
      </Metabolite>
      <Metabolite key="Metabolite_55" name="alb" simulationType="reactions" compartment="Compartment_7">
      </Metabolite>
      <Metabolite key="Metabolite_79" name="gal" simulationType="reactions" compartment="Compartment_7">
      </Metabolite>
      <Metabolite key="Metabolite_103" name="galM" simulationType="reactions" compartment="Compartment_7">
      </Metabolite>
      <Metabolite key="Metabolite_127" name="h2oM" simulationType="reactions" compartment="Compartment_7">
      </Metabolite>
      <Metabolite key="Metabolite_9" name="rbcM" simulationType="reactions" compartment="Compartment_9">
      </Metabolite>
      <Metabolite key="Metabolite_33" name="suc" simulationType="reactions" compartment="Compartment_9">
      </Metabolite>
      <Metabolite key="Metabolite_57" name="alb" simulationType="reactions" compartment="Compartment_9">
      </Metabolite>
      <Metabolite key="Metabolite_81" name="gal" simulationType="reactions" compartment="Compartment_9">
      </Metabolite>
      <Metabolite key="Metabolite_105" name="galM" simulationType="reactions" compartment="Compartment_9">
      </Metabolite>
      <Metabolite key="Metabolite_129" name="h2oM" simulationType="reactions" compartment="Compartment_9">
      </Metabolite>
      <Metabolite key="Metabolite_11" name="rbcM" simulationType="reactions" compartment="Compartment_11">
      </Metabolite>
      <Metabolite key="Metabolite_35" name="suc" simulationType="reactions" compartment="Compartment_11">
      </Metabolite>
      <Metabolite key="Metabolite_59" name="alb" simulationType="reactions" compartment="Compartment_11">
      </Metabolite>
      <Metabolite key="Metabolite_83" name="gal" simulationType="reactions" compartment="Compartment_11">
      </Metabolite>
      <Metabolite key="Metabolite_107" name="galM" simulationType="reactions" compartment="Compartment_11">
      </Metabolite>
      <Metabolite key="Metabolite_131" name="h2oM" simulationType="reactions" compartment="Compartment_11">
      </Metabolite>
      <Metabolite key="Metabolite_13" name="rbcM" simulationType="reactions" compartment="Compartment_13">
      </Metabolite>
      <Metabolite key="Metabolite_37" name="suc" simulationType="reactions" compartment="Compartment_13">
      </Metabolite>
      <Metabolite key="Metabolite_61" name="alb" simulationType="reactions" compartment="Compartment_13">
      </Metabolite>
      <Metabolite key="Metabolite_85" name="gal" simulationType="reactions" compartment="Compartment_13">
      </Metabolite>
      <Metabolite key="Metabolite_109" name="galM" simulationType="reactions" compartment="Compartment_13">
      </Metabolite>
      <Metabolite key="Metabolite_133" name="h2oM" simulationType="reactions" compartment="Compartment_13">
      </Metabolite>
      <Metabolite key="Metabolite_15" name="rbcM" simulationType="reactions" compartment="Compartment_15">
      </Metabolite>
      <Metabolite key="Metabolite_39" name="suc" simulationType="reactions" compartment="Compartment_15">
      </Metabolite>
      <Metabolite key="Metabolite_63" name="alb" simulationType="reactions" compartment="Compartment_15">
      </Metabolite>
      <Metabolite key="Metabolite_87" name="gal" simulationType="reactions" compartment="Compartment_15">
      </Metabolite>
      <Metabolite key="Metabolite_111" name="galM" simulationType="reactions" compartment="Compartment_15">
      </Metabolite>
      <Metabolite key="Metabolite_135" name="h2oM" simulationType="reactions" compartment="Compartment_15">
      </Metabolite>
      <Metabolite key="Metabolite_17" name="rbcM" simulationType="reactions" compartment="Compartment_17">
      </Metabolite>
      <Metabolite key="Metabolite_41" name="suc" simulationType="reactions" compartment="Compartment_17">
      </Metabolite>
      <Metabolite key="Metabolite_65" name="alb" simulationType="reactions" compartment="Compartment_17">
      </Metabolite>
      <Metabolite key="Metabolite_89" name="gal" simulationType="reactions" compartment="Compartment_17">
      </Metabolite>
      <Metabolite key="Metabolite_113" name="galM" simulationType="reactions" compartment="Compartment_17">
      </Metabolite>
      <Metabolite key="Metabolite_137" name="h2oM" simulationType="reactions" compartment="Compartment_17">
      </Metabolite>
      <Metabolite key="Metabolite_19" name="rbcM" simulationType="reactions" compartment="Compartment_19">
      </Metabolite>
      <Metabolite key="Metabolite_43" name="suc" simulationType="reactions" compartment="Compartment_19">
      </Metabolite>
      <Metabolite key="Metabolite_67" name="alb" simulationType="reactions" compartment="Compartment_19">
      </Metabolite>
      <Metabolite key="Metabolite_91" name="gal" simulationType="reactions" compartment="Compartment_19">
      </Metabolite>
      <Metabolite key="Metabolite_115" name="galM" simulationType="reactions" compartment="Compartment_19">
      </Metabolite>
      <Metabolite key="Metabolite_139" name="h2oM" simulationType="reactions" compartment="Compartment_19">
      </Metabolite>
      <Metabolite key="Metabolite_21" name="rbcM" simulationType="reactions" compartment="Compartment_21">
      </Metabolite>
      <Metabolite key="Metabolite_45" name="suc" simulationType="reactions" compartment="Compartment_21">
      </Metabolite>
      <Metabolite key="Metabolite_69" name="alb" simulationType="reactions" compartment="Compartment_21">
      </Metabolite>
      <Metabolite key="Metabolite_93" name="gal" simulationType="reactions" compartment="Compartment_21">
      </Metabolite>
      <Metabolite key="Metabolite_117" name="galM" simulationType="reactions" compartment="Compartment_21">
      </Metabolite>
      <Metabolite key="Metabolite_141" name="h2oM" simulationType="reactions" compartment="Compartment_21">
      </Metabolite>
      <Metabolite key="Metabolite_23" name="rbcM" simulationType="reactions" compartment="Compartment_23">
      </Metabolite>
      <Metabolite key="Metabolite_47" name="suc" simulationType="reactions" compartment="Compartment_23">
      </Metabolite>
      <Metabolite key="Metabolite_71" name="alb" simulationType="reactions" compartment="Compartment_23">
      </Metabolite>
      <Metabolite key="Metabolite_95" name="gal" simulationType="reactions" compartment="Compartment_23">
      </Metabolite>
      <Metabolite key="Metabolite_119" name="galM" simulationType="reactions" compartment="Compartment_23">
      </Metabolite>
      <Metabolite key="Metabolite_143" name="h2oM" simulationType="reactions" compartment="Compartment_23">
      </Metabolite>
      <Metabolite key="Metabolite_145" name="D-galactose" simulationType="reactions" compartment="Compartment_25">
      </Metabolite>
      <Metabolite key="Metabolite_147" name="D-galactose M" simulationType="reactions" compartment="Compartment_25">
      </Metabolite>
      <Metabolite key="Metabolite_149" name="H2O M" simulationType="reactions" compartment="Compartment_25">
      </Metabolite>
      <Metabolite key="Metabolite_151" name="D-glucose-1-phosphate" simulationType="reactions" compartment="Compartment_25">
      </Metabolite>
      <Metabolite key="Metabolite_153" name="D-glucose-6-phosphate" simulationType="reactions" compartment="Compartment_25">
      </Metabolite>
      <Metabolite key="Metabolite_155" name="D-galactose-1-phosphate" simulationType="reactions" compartment="Compartment_25">
      </Metabolite>
      <Metabolite key="Metabolite_157" name="UDP-D-glucose" simulationType="reactions" compartment="Compartment_25">
      </Metabolite>
      <Metabolite key="Metabolite_159" name="UDP-D-galactose" simulationType="reactions" compartment="Compartment_25">
      </Metabolite>
      <Metabolite key="Metabolite_161" name="D-galactitol" simulationType="reactions" compartment="Compartment_25">
      </Metabolite>
      <Metabolite key="Metabolite_163" name="ATP" simulationType="reactions" compartment="Compartment_25">
      </Metabolite>
      <Metabolite key="Metabolite_165" name="ADP" simulationType="reactions" compartment="Compartment_25">
      </Metabolite>
      <Metabolite key="Metabolite_167" name="UTP" simulationType="reactions" compartment="Compartment_25">
      </Metabolite>
      <Metabolite key="Metabolite_169" name="UDP" simulationType="reactions" compartment="Compartment_25">
      </Metabolite>
      <Metabolite key="Metabolite_171" name="Phosphate" simulationType="reactions" compartment="Compartment_25">
      </Metabolite>
      <Metabolite key="Metabolite_173" name="Pyrophosphate" simulationType="reactions" compartment="Compartment_25">
      </Metabolite>
      <Metabolite key="Metabolite_175" name="NADP" simulationType="reactions" compartment="Compartment_25">
      </Metabolite>
      <Metabolite key="Metabolite_177" name="NADPH" simulationType="reactions" compartment="Compartment_25">
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
      <ModelValue key="ModelValue_153" name="H01__GLUT2_GAL" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Reactions[galactose transport],Reference=Flux&gt;+&lt;CN=Root,Model=NoName,Vector=Reactions[galactose transport_3],Reference=Flux&gt;+&lt;CN=Root,Model=NoName,Vector=Reactions[galactose transport_5],Reference=Flux&gt;+&lt;CN=Root,Model=NoName,Vector=Reactions[galactose transport_7],Reference=Flux&gt;+&lt;CN=Root,Model=NoName,Vector=Reactions[galactose transport_9],Reference=Flux&gt;
        </Expression>
      </ModelValue>
      <ModelValue key="ModelValue_154" name="H01__GLUT2_GALM" simulationType="assignment">
        <Expression>
          &lt;CN=Root,Model=NoName,Vector=Reactions[galactose transport_2],Reference=Flux&gt;+&lt;CN=Root,Model=NoName,Vector=Reactions[galactose transport_4],Reference=Flux&gt;+&lt;CN=Root,Model=NoName,Vector=Reactions[galactose transport_6],Reference=Flux&gt;+&lt;CN=Root,Model=NoName,Vector=Reactions[galactose transport_8],Reference=Flux&gt;+&lt;CN=Root,Model=NoName,Vector=Reactions[galactose transport_10],Reference=Flux&gt;
        </Expression>
      </ModelValue>
    </ListOfModelValues>
    <ListOfReactions>
      <Reaction key="Reaction_0" name="FlowPPS001_rbcM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_1" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_3" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_117" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_118" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_39">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_246">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_258">
              <SourceParameter reference="Metabolite_1"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_265">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_1" name="FlowS001S002_rbcM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_3" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_7" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_119" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_120" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_40">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Metabolite_3"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_271">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_2" name="FlowS002S003_rbcM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_7" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_11" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_121" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_122" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_41">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_275">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_276">
              <SourceParameter reference="Metabolite_7"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_277">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_3" name="FlowS003S004_rbcM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_11" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_15" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_123" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_124" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_42">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_281">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_282">
              <SourceParameter reference="Metabolite_11"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_283">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_4" name="FlowS004S005_rbcM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_15" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_19" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_125" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_126" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_43">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_287">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_288">
              <SourceParameter reference="Metabolite_15"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_289">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_5" name="FlowS005PV_rbcM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_19" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_23" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_127" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_128" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_44">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_293">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_294">
              <SourceParameter reference="Metabolite_19"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_295">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_6" name="FlowPVNULL_rbcM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_23" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_129" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_130" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_45">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_300">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_301">
              <SourceParameter reference="Compartment_23"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_302">
              <SourceParameter reference="Metabolite_23"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_303">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_7" name="FlowPPS001_suc" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_25" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_27" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_131" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_132" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_46">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_254">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_308">
              <SourceParameter reference="Metabolite_25"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_309">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_8" name="FlowS001S002_suc" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_27" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_31" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_133" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_134" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_47">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_313">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_314">
              <SourceParameter reference="Metabolite_27"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_315">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_9" name="FlowS002S003_suc" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_31" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_35" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_135" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_136" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_48">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_319">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_320">
              <SourceParameter reference="Metabolite_31"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_321">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_10" name="FlowS003S004_suc" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_35" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_39" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_137" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_138" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_49">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_325">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_326">
              <SourceParameter reference="Metabolite_35"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_327">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_11" name="FlowS004S005_suc" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_39" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_43" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_139" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_140" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_50">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_331">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_332">
              <SourceParameter reference="Metabolite_39"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_333">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_12" name="FlowS005PV_suc" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_43" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_47" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_141" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_142" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_51">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_337">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_338">
              <SourceParameter reference="Metabolite_43"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_339">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_13" name="FlowPVNULL_suc" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_47" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_143" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_144" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_52">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_344">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_345">
              <SourceParameter reference="Compartment_23"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_346">
              <SourceParameter reference="Metabolite_47"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_347">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_14" name="FlowPPS001_alb" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_49" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_51" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_145" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_146" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_53">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_299">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_352">
              <SourceParameter reference="Metabolite_49"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_353">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_15" name="FlowS001S002_alb" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_51" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_55" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_147" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_148" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_54">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_357">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_358">
              <SourceParameter reference="Metabolite_51"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_359">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_16" name="FlowS002S003_alb" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_55" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_59" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_149" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_150" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_55">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_363">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_364">
              <SourceParameter reference="Metabolite_55"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_365">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_17" name="FlowS003S004_alb" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_59" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_63" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_151" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_152" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_56">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_369">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_370">
              <SourceParameter reference="Metabolite_59"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_371">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_18" name="FlowS004S005_alb" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_63" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_67" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_153" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_154" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_57">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_375">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_376">
              <SourceParameter reference="Metabolite_63"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_377">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_19" name="FlowS005PV_alb" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_67" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_71" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_155" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_156" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_58">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_381">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_382">
              <SourceParameter reference="Metabolite_67"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_383">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_20" name="FlowPVNULL_alb" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_71" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_157" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_158" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_59">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_388">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_389">
              <SourceParameter reference="Compartment_23"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_390">
              <SourceParameter reference="Metabolite_71"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_391">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_21" name="FlowPPS001_gal" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_73" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_75" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_159" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_160" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_60">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_343">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_396">
              <SourceParameter reference="Metabolite_73"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_397">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_22" name="FlowS001S002_gal" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_75" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_79" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_161" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_162" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_61">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_401">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_402">
              <SourceParameter reference="Metabolite_75"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_403">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_23" name="FlowS002S003_gal" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_79" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_83" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_163" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_164" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_62">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_407">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_408">
              <SourceParameter reference="Metabolite_79"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_409">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_24" name="FlowS003S004_gal" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_83" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_87" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_165" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_166" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_63">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_413">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_414">
              <SourceParameter reference="Metabolite_83"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_415">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_25" name="FlowS004S005_gal" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_87" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_91" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_167" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_168" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_64">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_419">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_420">
              <SourceParameter reference="Metabolite_87"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_421">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_26" name="FlowS005PV_gal" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_91" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_95" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_169" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_170" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_65">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_425">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_426">
              <SourceParameter reference="Metabolite_91"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_427">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_27" name="FlowPVNULL_gal" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_95" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_171" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_172" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_66">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_432">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_433">
              <SourceParameter reference="Compartment_23"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_434">
              <SourceParameter reference="Metabolite_95"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_435">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_28" name="FlowPPS001_galM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_97" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_99" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_173" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_174" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_67">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_387">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_440">
              <SourceParameter reference="Metabolite_97"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_441">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_29" name="FlowS001S002_galM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_99" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_103" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_175" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_176" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_68">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_445">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_446">
              <SourceParameter reference="Metabolite_99"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_447">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_30" name="FlowS002S003_galM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_103" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_107" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_177" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_178" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_69">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_451">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_452">
              <SourceParameter reference="Metabolite_103"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_453">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_31" name="FlowS003S004_galM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_107" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_111" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_179" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_180" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_70">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_457">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_458">
              <SourceParameter reference="Metabolite_107"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_459">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_32" name="FlowS004S005_galM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_111" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_115" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_181" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_182" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_71">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_463">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_464">
              <SourceParameter reference="Metabolite_111"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_465">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_33" name="FlowS005PV_galM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_115" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_119" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_183" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_184" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_72">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_469">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_470">
              <SourceParameter reference="Metabolite_115"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_471">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_34" name="FlowPVNULL_galM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_119" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_185" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_186" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_73">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_476">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_477">
              <SourceParameter reference="Compartment_23"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_478">
              <SourceParameter reference="Metabolite_119"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_479">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_35" name="FlowPPS001_h2oM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_121" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_123" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_187" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_188" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_74">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_431">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_484">
              <SourceParameter reference="Metabolite_121"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_485">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_36" name="FlowS001S002_h2oM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_123" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_127" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_189" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_190" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_75">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_489">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_490">
              <SourceParameter reference="Metabolite_123"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_491">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_37" name="FlowS002S003_h2oM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_127" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_131" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_191" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_192" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_76">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_495">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_496">
              <SourceParameter reference="Metabolite_127"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_497">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_38" name="FlowS003S004_h2oM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_131" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_135" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_193" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_194" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_77">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_501">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_502">
              <SourceParameter reference="Metabolite_131"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_503">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_39" name="FlowS004S005_h2oM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_135" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_139" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_195" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_196" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_78">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_507">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_508">
              <SourceParameter reference="Metabolite_135"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_509">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_40" name="FlowS005PV_h2oM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_139" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_143" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_197" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_198" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_79">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_513">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_514">
              <SourceParameter reference="Metabolite_139"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_515">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_41" name="FlowPVNULL_h2oM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_143" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_199" name="A_sin" value="6.08212e-11"/>
          <Constant key="Parameter_200" name="flow_sin" value="6e-05"/>
        </ListOfConstants>
        <KineticLaw function="Function_80">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_520">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_521">
              <SourceParameter reference="Compartment_23"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_522">
              <SourceParameter reference="Metabolite_143"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_523">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_42" name="DiffPPS001_rbcM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_1" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_3" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_201" name="Dx_sin_rbcM" value="0"/>
        </ListOfConstants>
        <KineticLaw function="Function_81">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_475">
              <SourceParameter reference="ModelValue_19"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_528">
              <SourceParameter reference="Metabolite_1"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_529">
              <SourceParameter reference="Metabolite_3"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_43" name="DiffS001S002_rbcM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_3" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_7" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_202" name="Dx_sin_rbcM" value="0"/>
        </ListOfConstants>
        <KineticLaw function="Function_82">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_533">
              <SourceParameter reference="ModelValue_19"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_534">
              <SourceParameter reference="Metabolite_3"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_535">
              <SourceParameter reference="Metabolite_7"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_44" name="DiffS002S003_rbcM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_7" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_11" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_203" name="Dx_sin_rbcM" value="0"/>
        </ListOfConstants>
        <KineticLaw function="Function_83">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_539">
              <SourceParameter reference="ModelValue_19"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_540">
              <SourceParameter reference="Metabolite_7"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_541">
              <SourceParameter reference="Metabolite_11"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_45" name="DiffS003S004_rbcM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_11" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_15" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_204" name="Dx_sin_rbcM" value="0"/>
        </ListOfConstants>
        <KineticLaw function="Function_84">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_545">
              <SourceParameter reference="ModelValue_19"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_546">
              <SourceParameter reference="Metabolite_11"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_547">
              <SourceParameter reference="Metabolite_15"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_46" name="DiffS004S005_rbcM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_15" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_19" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_205" name="Dx_sin_rbcM" value="0"/>
        </ListOfConstants>
        <KineticLaw function="Function_85">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_551">
              <SourceParameter reference="ModelValue_19"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_552">
              <SourceParameter reference="Metabolite_15"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_553">
              <SourceParameter reference="Metabolite_19"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_47" name="DiffS005PV_rbcM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_19" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_23" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_206" name="Dx_sin_rbcM" value="0"/>
        </ListOfConstants>
        <KineticLaw function="Function_86">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_557">
              <SourceParameter reference="ModelValue_19"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_558">
              <SourceParameter reference="Metabolite_23"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_559">
              <SourceParameter reference="Metabolite_19"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_48" name="DiffD001D002_rbcM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_5" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_9" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_207" name="Dx_dis_rbcM" value="0"/>
        </ListOfConstants>
        <KineticLaw function="Function_87">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_563">
              <SourceParameter reference="Metabolite_5"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_564">
              <SourceParameter reference="Metabolite_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_565">
              <SourceParameter reference="ModelValue_20"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_49" name="DiffD002D003_rbcM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_9" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_13" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_208" name="Dx_dis_rbcM" value="0"/>
        </ListOfConstants>
        <KineticLaw function="Function_88">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_569">
              <SourceParameter reference="Metabolite_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_570">
              <SourceParameter reference="Metabolite_13"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_571">
              <SourceParameter reference="ModelValue_20"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_50" name="DiffD003D004_rbcM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_13" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_17" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_209" name="Dx_dis_rbcM" value="0"/>
        </ListOfConstants>
        <KineticLaw function="Function_89">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_575">
              <SourceParameter reference="Metabolite_13"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_576">
              <SourceParameter reference="Metabolite_17"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_577">
              <SourceParameter reference="ModelValue_20"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_51" name="DiffD004D005_rbcM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_17" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_21" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_210" name="Dx_dis_rbcM" value="0"/>
        </ListOfConstants>
        <KineticLaw function="Function_90">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_581">
              <SourceParameter reference="Metabolite_17"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_582">
              <SourceParameter reference="Metabolite_21"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_583">
              <SourceParameter reference="ModelValue_20"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_52" name="DiffS001D001_rbcM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_3" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_5" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_211" name="Dy_sindis_rbcM" value="0"/>
        </ListOfConstants>
        <KineticLaw function="Function_91">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_587">
              <SourceParameter reference="Metabolite_5"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_588">
              <SourceParameter reference="ModelValue_21"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_589">
              <SourceParameter reference="Metabolite_3"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_53" name="DiffS002D002_rbcM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_7" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_9" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_212" name="Dy_sindis_rbcM" value="0"/>
        </ListOfConstants>
        <KineticLaw function="Function_92">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_593">
              <SourceParameter reference="Metabolite_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_594">
              <SourceParameter reference="ModelValue_21"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_595">
              <SourceParameter reference="Metabolite_7"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_54" name="DiffS003D003_rbcM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_11" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_13" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_213" name="Dy_sindis_rbcM" value="0"/>
        </ListOfConstants>
        <KineticLaw function="Function_93">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_599">
              <SourceParameter reference="Metabolite_13"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_600">
              <SourceParameter reference="ModelValue_21"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_601">
              <SourceParameter reference="Metabolite_11"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_55" name="DiffS004D004_rbcM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_15" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_17" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_214" name="Dy_sindis_rbcM" value="0"/>
        </ListOfConstants>
        <KineticLaw function="Function_94">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_605">
              <SourceParameter reference="Metabolite_17"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_606">
              <SourceParameter reference="ModelValue_21"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_607">
              <SourceParameter reference="Metabolite_15"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_56" name="DiffS005D005_rbcM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_19" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_21" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_215" name="Dy_sindis_rbcM" value="0"/>
        </ListOfConstants>
        <KineticLaw function="Function_95">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_611">
              <SourceParameter reference="Metabolite_21"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_612">
              <SourceParameter reference="ModelValue_21"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_613">
              <SourceParameter reference="Metabolite_19"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_57" name="DiffPPS001_suc" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_25" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_27" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_216" name="Dx_sin_suc" value="2.43285e-16"/>
        </ListOfConstants>
        <KineticLaw function="Function_96">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_617">
              <SourceParameter reference="ModelValue_23"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_618">
              <SourceParameter reference="Metabolite_25"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_619">
              <SourceParameter reference="Metabolite_27"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_58" name="DiffS001S002_suc" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_27" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_31" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_217" name="Dx_sin_suc" value="2.43285e-16"/>
        </ListOfConstants>
        <KineticLaw function="Function_97">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_623">
              <SourceParameter reference="ModelValue_23"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_624">
              <SourceParameter reference="Metabolite_27"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_625">
              <SourceParameter reference="Metabolite_31"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_59" name="DiffS002S003_suc" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_31" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_35" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_218" name="Dx_sin_suc" value="2.43285e-16"/>
        </ListOfConstants>
        <KineticLaw function="Function_98">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_629">
              <SourceParameter reference="ModelValue_23"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_630">
              <SourceParameter reference="Metabolite_31"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_631">
              <SourceParameter reference="Metabolite_35"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_60" name="DiffS003S004_suc" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_35" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_39" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_219" name="Dx_sin_suc" value="2.43285e-16"/>
        </ListOfConstants>
        <KineticLaw function="Function_99">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_635">
              <SourceParameter reference="ModelValue_23"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_636">
              <SourceParameter reference="Metabolite_35"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_637">
              <SourceParameter reference="Metabolite_39"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_61" name="DiffS004S005_suc" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_39" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_43" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_220" name="Dx_sin_suc" value="2.43285e-16"/>
        </ListOfConstants>
        <KineticLaw function="Function_100">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_641">
              <SourceParameter reference="ModelValue_23"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_642">
              <SourceParameter reference="Metabolite_39"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_643">
              <SourceParameter reference="Metabolite_43"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_62" name="DiffS005PV_suc" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_43" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_47" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_221" name="Dx_sin_suc" value="2.43285e-16"/>
        </ListOfConstants>
        <KineticLaw function="Function_101">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_647">
              <SourceParameter reference="ModelValue_23"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_648">
              <SourceParameter reference="Metabolite_47"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_649">
              <SourceParameter reference="Metabolite_43"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_63" name="DiffD001D002_suc" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_29" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_33" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_222" name="Dx_dis_suc" value="9.65097e-17"/>
        </ListOfConstants>
        <KineticLaw function="Function_102">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_653">
              <SourceParameter reference="Metabolite_29"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_654">
              <SourceParameter reference="Metabolite_33"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_655">
              <SourceParameter reference="ModelValue_24"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_64" name="DiffD002D003_suc" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_33" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_37" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_223" name="Dx_dis_suc" value="9.65097e-17"/>
        </ListOfConstants>
        <KineticLaw function="Function_103">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_659">
              <SourceParameter reference="Metabolite_33"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_660">
              <SourceParameter reference="Metabolite_37"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_661">
              <SourceParameter reference="ModelValue_24"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_65" name="DiffD003D004_suc" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_37" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_41" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_224" name="Dx_dis_suc" value="9.65097e-17"/>
        </ListOfConstants>
        <KineticLaw function="Function_104">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_665">
              <SourceParameter reference="Metabolite_37"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_666">
              <SourceParameter reference="Metabolite_41"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_667">
              <SourceParameter reference="ModelValue_24"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_66" name="DiffD004D005_suc" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_41" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_45" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_225" name="Dx_dis_suc" value="9.65097e-17"/>
        </ListOfConstants>
        <KineticLaw function="Function_105">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_671">
              <SourceParameter reference="Metabolite_41"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_672">
              <SourceParameter reference="Metabolite_45"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_673">
              <SourceParameter reference="ModelValue_24"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_67" name="DiffS001D001_suc" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_27" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_29" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_226" name="Dy_sindis_suc" value="1.3823e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_106">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_677">
              <SourceParameter reference="Metabolite_29"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_678">
              <SourceParameter reference="ModelValue_25"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_679">
              <SourceParameter reference="Metabolite_27"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_68" name="DiffS002D002_suc" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_31" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_33" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_227" name="Dy_sindis_suc" value="1.3823e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_107">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_683">
              <SourceParameter reference="Metabolite_33"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_684">
              <SourceParameter reference="ModelValue_25"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_685">
              <SourceParameter reference="Metabolite_31"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_69" name="DiffS003D003_suc" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_35" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_37" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_228" name="Dy_sindis_suc" value="1.3823e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_108">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_689">
              <SourceParameter reference="Metabolite_37"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_690">
              <SourceParameter reference="ModelValue_25"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_691">
              <SourceParameter reference="Metabolite_35"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_70" name="DiffS004D004_suc" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_39" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_41" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_229" name="Dy_sindis_suc" value="1.3823e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_109">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_695">
              <SourceParameter reference="Metabolite_41"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_696">
              <SourceParameter reference="ModelValue_25"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_697">
              <SourceParameter reference="Metabolite_39"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_71" name="DiffS005D005_suc" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_43" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_45" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_230" name="Dy_sindis_suc" value="1.3823e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_110">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_701">
              <SourceParameter reference="Metabolite_45"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_702">
              <SourceParameter reference="ModelValue_25"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_703">
              <SourceParameter reference="Metabolite_43"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_72" name="DiffPPS001_alb" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_49" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_51" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_231" name="Dx_sin_alb" value="6.08212e-17"/>
        </ListOfConstants>
        <KineticLaw function="Function_111">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_707">
              <SourceParameter reference="ModelValue_27"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_708">
              <SourceParameter reference="Metabolite_49"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_709">
              <SourceParameter reference="Metabolite_51"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_73" name="DiffS001S002_alb" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_51" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_55" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_232" name="Dx_sin_alb" value="6.08212e-17"/>
        </ListOfConstants>
        <KineticLaw function="Function_112">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_713">
              <SourceParameter reference="ModelValue_27"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_714">
              <SourceParameter reference="Metabolite_51"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_715">
              <SourceParameter reference="Metabolite_55"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_74" name="DiffS002S003_alb" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_55" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_59" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_233" name="Dx_sin_alb" value="6.08212e-17"/>
        </ListOfConstants>
        <KineticLaw function="Function_113">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_719">
              <SourceParameter reference="ModelValue_27"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_720">
              <SourceParameter reference="Metabolite_55"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_721">
              <SourceParameter reference="Metabolite_59"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_75" name="DiffS003S004_alb" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_59" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_63" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_234" name="Dx_sin_alb" value="6.08212e-17"/>
        </ListOfConstants>
        <KineticLaw function="Function_114">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_725">
              <SourceParameter reference="ModelValue_27"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_726">
              <SourceParameter reference="Metabolite_59"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_727">
              <SourceParameter reference="Metabolite_63"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_76" name="DiffS004S005_alb" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_63" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_67" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_235" name="Dx_sin_alb" value="6.08212e-17"/>
        </ListOfConstants>
        <KineticLaw function="Function_115">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_731">
              <SourceParameter reference="ModelValue_27"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_732">
              <SourceParameter reference="Metabolite_63"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_733">
              <SourceParameter reference="Metabolite_67"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_77" name="DiffS005PV_alb" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_67" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_71" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_236" name="Dx_sin_alb" value="6.08212e-17"/>
        </ListOfConstants>
        <KineticLaw function="Function_116">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_737">
              <SourceParameter reference="ModelValue_27"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_738">
              <SourceParameter reference="Metabolite_71"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_739">
              <SourceParameter reference="Metabolite_67"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_78" name="DiffD001D002_alb" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_53" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_57" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_237" name="Dx_dis_alb" value="2.41274e-17"/>
        </ListOfConstants>
        <KineticLaw function="Function_117">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_743">
              <SourceParameter reference="Metabolite_53"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_744">
              <SourceParameter reference="Metabolite_57"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_745">
              <SourceParameter reference="ModelValue_28"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_79" name="DiffD002D003_alb" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_57" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_61" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_238" name="Dx_dis_alb" value="2.41274e-17"/>
        </ListOfConstants>
        <KineticLaw function="Function_118">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_749">
              <SourceParameter reference="Metabolite_57"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_750">
              <SourceParameter reference="Metabolite_61"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_751">
              <SourceParameter reference="ModelValue_28"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_80" name="DiffD003D004_alb" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_61" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_65" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_239" name="Dx_dis_alb" value="2.41274e-17"/>
        </ListOfConstants>
        <KineticLaw function="Function_119">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_755">
              <SourceParameter reference="Metabolite_61"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_756">
              <SourceParameter reference="Metabolite_65"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_757">
              <SourceParameter reference="ModelValue_28"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_81" name="DiffD004D005_alb" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_65" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_69" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_240" name="Dx_dis_alb" value="2.41274e-17"/>
        </ListOfConstants>
        <KineticLaw function="Function_120">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_761">
              <SourceParameter reference="Metabolite_65"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_762">
              <SourceParameter reference="Metabolite_69"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_763">
              <SourceParameter reference="ModelValue_28"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_82" name="DiffS001D001_alb" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_51" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_53" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_241" name="Dy_sindis_alb" value="3.45575e-13"/>
        </ListOfConstants>
        <KineticLaw function="Function_121">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_767">
              <SourceParameter reference="Metabolite_53"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_768">
              <SourceParameter reference="ModelValue_29"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_769">
              <SourceParameter reference="Metabolite_51"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_83" name="DiffS002D002_alb" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_55" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_57" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_242" name="Dy_sindis_alb" value="3.45575e-13"/>
        </ListOfConstants>
        <KineticLaw function="Function_122">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_773">
              <SourceParameter reference="Metabolite_57"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_774">
              <SourceParameter reference="ModelValue_29"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_775">
              <SourceParameter reference="Metabolite_55"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_84" name="DiffS003D003_alb" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_59" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_61" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_243" name="Dy_sindis_alb" value="3.45575e-13"/>
        </ListOfConstants>
        <KineticLaw function="Function_123">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_779">
              <SourceParameter reference="Metabolite_61"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_780">
              <SourceParameter reference="ModelValue_29"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_781">
              <SourceParameter reference="Metabolite_59"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_85" name="DiffS004D004_alb" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_63" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_65" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_244" name="Dy_sindis_alb" value="3.45575e-13"/>
        </ListOfConstants>
        <KineticLaw function="Function_124">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_785">
              <SourceParameter reference="Metabolite_65"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_786">
              <SourceParameter reference="ModelValue_29"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_787">
              <SourceParameter reference="Metabolite_63"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_86" name="DiffS005D005_alb" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_67" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_69" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_245" name="Dy_sindis_alb" value="3.45575e-13"/>
        </ListOfConstants>
        <KineticLaw function="Function_125">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_791">
              <SourceParameter reference="Metabolite_69"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_792">
              <SourceParameter reference="ModelValue_29"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_793">
              <SourceParameter reference="Metabolite_67"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_87" name="DiffPPS001_gal" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_73" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_75" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_246" name="Dx_sin_gal" value="2.43285e-16"/>
        </ListOfConstants>
        <KineticLaw function="Function_126">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_797">
              <SourceParameter reference="ModelValue_31"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_798">
              <SourceParameter reference="Metabolite_73"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_799">
              <SourceParameter reference="Metabolite_75"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_88" name="DiffS001S002_gal" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_75" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_79" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_247" name="Dx_sin_gal" value="2.43285e-16"/>
        </ListOfConstants>
        <KineticLaw function="Function_127">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_803">
              <SourceParameter reference="ModelValue_31"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_804">
              <SourceParameter reference="Metabolite_75"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_805">
              <SourceParameter reference="Metabolite_79"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_89" name="DiffS002S003_gal" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_79" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_83" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_248" name="Dx_sin_gal" value="2.43285e-16"/>
        </ListOfConstants>
        <KineticLaw function="Function_128">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_809">
              <SourceParameter reference="ModelValue_31"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_810">
              <SourceParameter reference="Metabolite_79"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_811">
              <SourceParameter reference="Metabolite_83"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_90" name="DiffS003S004_gal" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_83" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_87" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_249" name="Dx_sin_gal" value="2.43285e-16"/>
        </ListOfConstants>
        <KineticLaw function="Function_129">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_815">
              <SourceParameter reference="ModelValue_31"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_816">
              <SourceParameter reference="Metabolite_83"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_817">
              <SourceParameter reference="Metabolite_87"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_91" name="DiffS004S005_gal" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_87" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_91" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_250" name="Dx_sin_gal" value="2.43285e-16"/>
        </ListOfConstants>
        <KineticLaw function="Function_130">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_821">
              <SourceParameter reference="ModelValue_31"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_822">
              <SourceParameter reference="Metabolite_87"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_823">
              <SourceParameter reference="Metabolite_91"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_92" name="DiffS005PV_gal" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_91" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_95" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_251" name="Dx_sin_gal" value="2.43285e-16"/>
        </ListOfConstants>
        <KineticLaw function="Function_131">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_827">
              <SourceParameter reference="ModelValue_31"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_828">
              <SourceParameter reference="Metabolite_95"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_829">
              <SourceParameter reference="Metabolite_91"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_93" name="DiffD001D002_gal" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_77" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_81" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_252" name="Dx_dis_gal" value="9.65097e-17"/>
        </ListOfConstants>
        <KineticLaw function="Function_132">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_833">
              <SourceParameter reference="Metabolite_77"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_834">
              <SourceParameter reference="Metabolite_81"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_835">
              <SourceParameter reference="ModelValue_32"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_94" name="DiffD002D003_gal" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_81" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_85" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_253" name="Dx_dis_gal" value="9.65097e-17"/>
        </ListOfConstants>
        <KineticLaw function="Function_133">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_839">
              <SourceParameter reference="Metabolite_81"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_840">
              <SourceParameter reference="Metabolite_85"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_841">
              <SourceParameter reference="ModelValue_32"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_95" name="DiffD003D004_gal" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_85" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_89" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_254" name="Dx_dis_gal" value="9.65097e-17"/>
        </ListOfConstants>
        <KineticLaw function="Function_134">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_845">
              <SourceParameter reference="Metabolite_85"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_846">
              <SourceParameter reference="Metabolite_89"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_847">
              <SourceParameter reference="ModelValue_32"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_96" name="DiffD004D005_gal" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_89" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_93" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_255" name="Dx_dis_gal" value="9.65097e-17"/>
        </ListOfConstants>
        <KineticLaw function="Function_135">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_851">
              <SourceParameter reference="Metabolite_89"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_852">
              <SourceParameter reference="Metabolite_93"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_853">
              <SourceParameter reference="ModelValue_32"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_97" name="DiffS001D001_gal" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_75" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_77" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_256" name="Dy_sindis_gal" value="1.3823e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_136">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_857">
              <SourceParameter reference="Metabolite_77"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_858">
              <SourceParameter reference="ModelValue_33"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_859">
              <SourceParameter reference="Metabolite_75"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_98" name="DiffS002D002_gal" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_79" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_81" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_257" name="Dy_sindis_gal" value="1.3823e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_137">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_863">
              <SourceParameter reference="Metabolite_81"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_864">
              <SourceParameter reference="ModelValue_33"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_865">
              <SourceParameter reference="Metabolite_79"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_99" name="DiffS003D003_gal" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_83" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_85" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_258" name="Dy_sindis_gal" value="1.3823e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_138">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_869">
              <SourceParameter reference="Metabolite_85"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_870">
              <SourceParameter reference="ModelValue_33"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_871">
              <SourceParameter reference="Metabolite_83"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_100" name="DiffS004D004_gal" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_87" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_89" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_259" name="Dy_sindis_gal" value="1.3823e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_139">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_875">
              <SourceParameter reference="Metabolite_89"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_876">
              <SourceParameter reference="ModelValue_33"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_877">
              <SourceParameter reference="Metabolite_87"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_101" name="DiffS005D005_gal" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_91" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_93" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_260" name="Dy_sindis_gal" value="1.3823e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_140">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_881">
              <SourceParameter reference="Metabolite_93"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_882">
              <SourceParameter reference="ModelValue_33"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_883">
              <SourceParameter reference="Metabolite_91"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_102" name="DiffPPS001_galM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_97" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_99" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_261" name="Dx_sin_galM" value="2.43285e-16"/>
        </ListOfConstants>
        <KineticLaw function="Function_141">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_887">
              <SourceParameter reference="ModelValue_35"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_888">
              <SourceParameter reference="Metabolite_97"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_889">
              <SourceParameter reference="Metabolite_99"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_103" name="DiffS001S002_galM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_99" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_103" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_262" name="Dx_sin_galM" value="2.43285e-16"/>
        </ListOfConstants>
        <KineticLaw function="Function_142">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_893">
              <SourceParameter reference="ModelValue_35"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_894">
              <SourceParameter reference="Metabolite_99"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_895">
              <SourceParameter reference="Metabolite_103"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_104" name="DiffS002S003_galM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_103" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_107" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_263" name="Dx_sin_galM" value="2.43285e-16"/>
        </ListOfConstants>
        <KineticLaw function="Function_143">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_899">
              <SourceParameter reference="ModelValue_35"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_900">
              <SourceParameter reference="Metabolite_103"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_901">
              <SourceParameter reference="Metabolite_107"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_105" name="DiffS003S004_galM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_107" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_111" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_264" name="Dx_sin_galM" value="2.43285e-16"/>
        </ListOfConstants>
        <KineticLaw function="Function_144">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_905">
              <SourceParameter reference="ModelValue_35"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_906">
              <SourceParameter reference="Metabolite_107"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_907">
              <SourceParameter reference="Metabolite_111"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_106" name="DiffS004S005_galM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_111" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_115" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_265" name="Dx_sin_galM" value="2.43285e-16"/>
        </ListOfConstants>
        <KineticLaw function="Function_145">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_911">
              <SourceParameter reference="ModelValue_35"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_912">
              <SourceParameter reference="Metabolite_111"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_913">
              <SourceParameter reference="Metabolite_115"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_107" name="DiffS005PV_galM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_115" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_119" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_266" name="Dx_sin_galM" value="2.43285e-16"/>
        </ListOfConstants>
        <KineticLaw function="Function_146">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_917">
              <SourceParameter reference="ModelValue_35"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_918">
              <SourceParameter reference="Metabolite_119"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_919">
              <SourceParameter reference="Metabolite_115"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_108" name="DiffD001D002_galM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_101" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_105" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_267" name="Dx_dis_galM" value="9.65097e-17"/>
        </ListOfConstants>
        <KineticLaw function="Function_147">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_923">
              <SourceParameter reference="Metabolite_101"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_924">
              <SourceParameter reference="Metabolite_105"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_925">
              <SourceParameter reference="ModelValue_36"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_109" name="DiffD002D003_galM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_105" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_109" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_268" name="Dx_dis_galM" value="9.65097e-17"/>
        </ListOfConstants>
        <KineticLaw function="Function_148">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_929">
              <SourceParameter reference="Metabolite_105"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_930">
              <SourceParameter reference="Metabolite_109"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_931">
              <SourceParameter reference="ModelValue_36"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_110" name="DiffD003D004_galM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_109" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_113" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_269" name="Dx_dis_galM" value="9.65097e-17"/>
        </ListOfConstants>
        <KineticLaw function="Function_149">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_935">
              <SourceParameter reference="Metabolite_109"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_936">
              <SourceParameter reference="Metabolite_113"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_937">
              <SourceParameter reference="ModelValue_36"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_111" name="DiffD004D005_galM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_113" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_117" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_270" name="Dx_dis_galM" value="9.65097e-17"/>
        </ListOfConstants>
        <KineticLaw function="Function_150">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_941">
              <SourceParameter reference="Metabolite_113"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_942">
              <SourceParameter reference="Metabolite_117"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_943">
              <SourceParameter reference="ModelValue_36"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_112" name="DiffS001D001_galM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_99" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_101" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_271" name="Dy_sindis_galM" value="1.3823e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_151">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_947">
              <SourceParameter reference="Metabolite_101"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_948">
              <SourceParameter reference="ModelValue_37"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_949">
              <SourceParameter reference="Metabolite_99"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_113" name="DiffS002D002_galM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_103" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_105" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_272" name="Dy_sindis_galM" value="1.3823e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_152">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_953">
              <SourceParameter reference="Metabolite_105"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_954">
              <SourceParameter reference="ModelValue_37"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_955">
              <SourceParameter reference="Metabolite_103"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_114" name="DiffS003D003_galM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_107" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_109" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_273" name="Dy_sindis_galM" value="1.3823e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_153">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_959">
              <SourceParameter reference="Metabolite_109"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_960">
              <SourceParameter reference="ModelValue_37"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_961">
              <SourceParameter reference="Metabolite_107"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_115" name="DiffS004D004_galM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_111" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_113" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_274" name="Dy_sindis_galM" value="1.3823e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_154">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_965">
              <SourceParameter reference="Metabolite_113"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_966">
              <SourceParameter reference="ModelValue_37"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_967">
              <SourceParameter reference="Metabolite_111"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_116" name="DiffS005D005_galM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_115" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_117" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_275" name="Dy_sindis_galM" value="1.3823e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_155">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_971">
              <SourceParameter reference="Metabolite_117"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_972">
              <SourceParameter reference="ModelValue_37"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_973">
              <SourceParameter reference="Metabolite_115"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_117" name="DiffPPS001_h2oM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_121" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_123" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_276" name="Dx_sin_h2oM" value="1.21642e-15"/>
        </ListOfConstants>
        <KineticLaw function="Function_156">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_977">
              <SourceParameter reference="ModelValue_39"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_978">
              <SourceParameter reference="Metabolite_121"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_979">
              <SourceParameter reference="Metabolite_123"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_118" name="DiffS001S002_h2oM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_123" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_127" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_277" name="Dx_sin_h2oM" value="1.21642e-15"/>
        </ListOfConstants>
        <KineticLaw function="Function_157">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_983">
              <SourceParameter reference="ModelValue_39"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_984">
              <SourceParameter reference="Metabolite_123"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_985">
              <SourceParameter reference="Metabolite_127"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_119" name="DiffS002S003_h2oM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_127" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_131" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_278" name="Dx_sin_h2oM" value="1.21642e-15"/>
        </ListOfConstants>
        <KineticLaw function="Function_158">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_989">
              <SourceParameter reference="ModelValue_39"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_990">
              <SourceParameter reference="Metabolite_127"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_991">
              <SourceParameter reference="Metabolite_131"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_120" name="DiffS003S004_h2oM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_131" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_135" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_279" name="Dx_sin_h2oM" value="1.21642e-15"/>
        </ListOfConstants>
        <KineticLaw function="Function_159">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_995">
              <SourceParameter reference="ModelValue_39"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_996">
              <SourceParameter reference="Metabolite_131"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_997">
              <SourceParameter reference="Metabolite_135"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_121" name="DiffS004S005_h2oM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_135" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_139" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_280" name="Dx_sin_h2oM" value="1.21642e-15"/>
        </ListOfConstants>
        <KineticLaw function="Function_160">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_1001">
              <SourceParameter reference="ModelValue_39"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1002">
              <SourceParameter reference="Metabolite_135"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1003">
              <SourceParameter reference="Metabolite_139"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_122" name="DiffS005PV_h2oM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_139" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_143" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_281" name="Dx_sin_h2oM" value="1.21642e-15"/>
        </ListOfConstants>
        <KineticLaw function="Function_161">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_1007">
              <SourceParameter reference="ModelValue_39"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1008">
              <SourceParameter reference="Metabolite_143"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1009">
              <SourceParameter reference="Metabolite_139"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_123" name="DiffD001D002_h2oM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_125" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_129" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_282" name="Dx_dis_h2oM" value="4.82549e-16"/>
        </ListOfConstants>
        <KineticLaw function="Function_162">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_1013">
              <SourceParameter reference="Metabolite_125"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1014">
              <SourceParameter reference="Metabolite_129"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1015">
              <SourceParameter reference="ModelValue_40"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_124" name="DiffD002D003_h2oM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_129" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_133" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_283" name="Dx_dis_h2oM" value="4.82549e-16"/>
        </ListOfConstants>
        <KineticLaw function="Function_163">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_1019">
              <SourceParameter reference="Metabolite_129"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1020">
              <SourceParameter reference="Metabolite_133"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1021">
              <SourceParameter reference="ModelValue_40"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_125" name="DiffD003D004_h2oM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_133" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_137" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_284" name="Dx_dis_h2oM" value="4.82549e-16"/>
        </ListOfConstants>
        <KineticLaw function="Function_164">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_1025">
              <SourceParameter reference="Metabolite_133"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1026">
              <SourceParameter reference="Metabolite_137"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1027">
              <SourceParameter reference="ModelValue_40"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_126" name="DiffD004D005_h2oM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_137" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_141" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_285" name="Dx_dis_h2oM" value="4.82549e-16"/>
        </ListOfConstants>
        <KineticLaw function="Function_165">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_1031">
              <SourceParameter reference="Metabolite_137"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1032">
              <SourceParameter reference="Metabolite_141"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1033">
              <SourceParameter reference="ModelValue_40"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_127" name="DiffS001D001_h2oM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_123" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_125" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_286" name="Dy_sindis_h2oM" value="6.9115e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_166">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_1037">
              <SourceParameter reference="Metabolite_125"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1038">
              <SourceParameter reference="ModelValue_41"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1039">
              <SourceParameter reference="Metabolite_123"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_128" name="DiffS002D002_h2oM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_127" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_129" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_287" name="Dy_sindis_h2oM" value="6.9115e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_167">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_1043">
              <SourceParameter reference="Metabolite_129"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1044">
              <SourceParameter reference="ModelValue_41"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1045">
              <SourceParameter reference="Metabolite_127"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_129" name="DiffS003D003_h2oM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_131" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_133" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_288" name="Dy_sindis_h2oM" value="6.9115e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_168">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_1049">
              <SourceParameter reference="Metabolite_133"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1050">
              <SourceParameter reference="ModelValue_41"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1051">
              <SourceParameter reference="Metabolite_131"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_130" name="DiffS004D004_h2oM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_135" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_137" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_289" name="Dy_sindis_h2oM" value="6.9115e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_169">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_1055">
              <SourceParameter reference="Metabolite_137"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1056">
              <SourceParameter reference="ModelValue_41"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1057">
              <SourceParameter reference="Metabolite_135"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_131" name="DiffS005D005_h2oM" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_139" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_141" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_290" name="Dy_sindis_h2oM" value="6.9115e-12"/>
        </ListOfConstants>
        <KineticLaw function="Function_170">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_1061">
              <SourceParameter reference="Metabolite_141"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1062">
              <SourceParameter reference="ModelValue_41"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1063">
              <SourceParameter reference="Metabolite_139"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_132" name="Galactokinase (H01)" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_145" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_163" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_155" stoichiometry="1"/>
          <Product metabolite="Metabolite_165" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_291" name="GALK_k_atp" value="0.034"/>
          <Constant key="Parameter_292" name="GALK_k_gal" value="0.97"/>
          <Constant key="Parameter_293" name="GALK_keq" value="50"/>
          <Constant key="Parameter_294" name="GALK_ki_gal1p" value="5.3"/>
          <Constant key="Parameter_295" name="H01__GALK_Vmax" value="8.7e-15"/>
          <Constant key="Parameter_296" name="H01__GALK_dm" value="81.9234"/>
        </ListOfConstants>
        <KineticLaw function="Function_171">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_1075">
              <SourceParameter reference="ModelValue_57"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1076">
              <SourceParameter reference="ModelValue_56"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1077">
              <SourceParameter reference="ModelValue_51"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1078">
              <SourceParameter reference="ModelValue_54"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1079">
              <SourceParameter reference="Compartment_25"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1080">
              <SourceParameter reference="ModelValue_59"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1081">
              <SourceParameter reference="ModelValue_60"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1082">
              <SourceParameter reference="Metabolite_165"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1083">
              <SourceParameter reference="Metabolite_163"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1084">
              <SourceParameter reference="Metabolite_145"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1085">
              <SourceParameter reference="Metabolite_155"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_133" name="Galactokinase (H01)_2" reversible="false" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_147" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_163" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_155" stoichiometry="1"/>
          <Product metabolite="Metabolite_165" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_297" name="GALK_k_atp" value="0.034"/>
          <Constant key="Parameter_298" name="GALK_k_gal" value="0.97"/>
          <Constant key="Parameter_299" name="GALK_ki_gal1p" value="5.3"/>
          <Constant key="Parameter_300" name="H01__GALK_Vmax" value="8.7e-15"/>
          <Constant key="Parameter_301" name="H01__GALK_dm" value="81.9234"/>
        </ListOfConstants>
        <KineticLaw function="Function_172">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_262">
              <SourceParameter reference="ModelValue_57"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_519">
              <SourceParameter reference="ModelValue_56"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1097">
              <SourceParameter reference="ModelValue_54"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1098">
              <SourceParameter reference="Compartment_25"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1099">
              <SourceParameter reference="ModelValue_59"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1100">
              <SourceParameter reference="ModelValue_60"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1101">
              <SourceParameter reference="Metabolite_163"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1102">
              <SourceParameter reference="Metabolite_155"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1103">
              <SourceParameter reference="Metabolite_147"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_134" name="Inositol monophosphatase (H01)" reversible="false" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_155" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_145" stoichiometry="1"/>
          <Product metabolite="Metabolite_171" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_302" name="H01__IMP_Vmax" value="4.35e-16"/>
          <Constant key="Parameter_303" name="IMP_k_gal1p" value="0.35"/>
        </ListOfConstants>
        <KineticLaw function="Function_173">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_1067">
              <SourceParameter reference="Compartment_25"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1072">
              <SourceParameter reference="ModelValue_64"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1073">
              <SourceParameter reference="Metabolite_155"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1069">
              <SourceParameter reference="ModelValue_62"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_135" name="ATP synthase (H01)" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_165" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_171" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_163" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_304" name="ATPS_k_adp" value="0.1"/>
          <Constant key="Parameter_305" name="ATPS_k_atp" value="0.5"/>
          <Constant key="Parameter_306" name="ATPS_k_phos" value="0.1"/>
          <Constant key="Parameter_307" name="ATPS_keq" value="0.58"/>
          <Constant key="Parameter_308" name="H01__ATPS_Vmax" value="8.7e-13"/>
        </ListOfConstants>
        <KineticLaw function="Function_174">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_1121">
              <SourceParameter reference="ModelValue_67"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1122">
              <SourceParameter reference="ModelValue_68"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1123">
              <SourceParameter reference="ModelValue_69"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1124">
              <SourceParameter reference="ModelValue_66"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1125">
              <SourceParameter reference="Compartment_25"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1126">
              <SourceParameter reference="ModelValue_71"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1127">
              <SourceParameter reference="Metabolite_165"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1128">
              <SourceParameter reference="Metabolite_163"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1129">
              <SourceParameter reference="Metabolite_171"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_136" name="Aldose reductase (H01)" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_145" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_177" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_161" stoichiometry="1"/>
          <Product metabolite="Metabolite_175" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_309" name="ALDR_k_gal" value="40"/>
          <Constant key="Parameter_310" name="ALDR_k_galtol" value="40"/>
          <Constant key="Parameter_311" name="ALDR_k_nadp" value="0.1"/>
          <Constant key="Parameter_312" name="ALDR_k_nadph" value="0.1"/>
          <Constant key="Parameter_313" name="ALDR_keq" value="4"/>
          <Constant key="Parameter_314" name="H01__ALDR_Vmax" value="8.7e-09"/>
        </ListOfConstants>
        <KineticLaw function="Function_175">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_1141">
              <SourceParameter reference="ModelValue_74"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1142">
              <SourceParameter reference="ModelValue_75"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1143">
              <SourceParameter reference="ModelValue_76"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1144">
              <SourceParameter reference="ModelValue_77"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1145">
              <SourceParameter reference="ModelValue_73"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1146">
              <SourceParameter reference="Compartment_25"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1147">
              <SourceParameter reference="ModelValue_79"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1148">
              <SourceParameter reference="Metabolite_145"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1149">
              <SourceParameter reference="Metabolite_161"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1150">
              <SourceParameter reference="Metabolite_175"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1151">
              <SourceParameter reference="Metabolite_177"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_137" name="NADP Reductase (H01)" reversible="false" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_175" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_177" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_315" name="H01__NADPR_Vmax" value="8.7e-19"/>
          <Constant key="Parameter_316" name="NADPR_k_nadp" value="0.015"/>
          <Constant key="Parameter_317" name="NADPR_keq" value="1"/>
          <Constant key="Parameter_318" name="NADPR_ki_nadph" value="0.01"/>
        </ListOfConstants>
        <KineticLaw function="Function_176">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_1074">
              <SourceParameter reference="Compartment_25"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1068">
              <SourceParameter reference="ModelValue_85"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1139">
              <SourceParameter reference="Metabolite_175"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1117">
              <SourceParameter reference="Metabolite_177"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1163">
              <SourceParameter reference="ModelValue_82"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1164">
              <SourceParameter reference="ModelValue_81"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1165">
              <SourceParameter reference="ModelValue_83"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_138" name="Galactose-1-phosphate uridyl transferase (H01)" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_155" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_157" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_151" stoichiometry="1"/>
          <Product metabolite="Metabolite_159" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfModifiers>
          <Modifier metabolite="Metabolite_169" stoichiometry="1"/>
          <Modifier metabolite="Metabolite_167" stoichiometry="1"/>
        </ListOfModifiers>
        <ListOfConstants>
          <Constant key="Parameter_319" name="GALT_k_gal1p" value="1.25"/>
          <Constant key="Parameter_320" name="GALT_k_glc1p" value="0.37"/>
          <Constant key="Parameter_321" name="GALT_k_udpgal" value="0.5"/>
          <Constant key="Parameter_322" name="GALT_k_udpglc" value="0.43"/>
          <Constant key="Parameter_323" name="GALT_keq" value="1"/>
          <Constant key="Parameter_324" name="GALT_ki_udp" value="0.35"/>
          <Constant key="Parameter_325" name="GALT_ki_utp" value="0.13"/>
          <Constant key="Parameter_326" name="H01__GALT_Vmax" value="6.9948e-14"/>
        </ListOfConstants>
        <KineticLaw function="Function_177">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_1181">
              <SourceParameter reference="ModelValue_93"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1182">
              <SourceParameter reference="ModelValue_88"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1183">
              <SourceParameter reference="ModelValue_89"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1184">
              <SourceParameter reference="ModelValue_94"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1185">
              <SourceParameter reference="ModelValue_87"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1186">
              <SourceParameter reference="ModelValue_91"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1187">
              <SourceParameter reference="ModelValue_90"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1188">
              <SourceParameter reference="Compartment_25"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1189">
              <SourceParameter reference="ModelValue_96"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1190">
              <SourceParameter reference="Metabolite_155"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1191">
              <SourceParameter reference="Metabolite_151"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1192">
              <SourceParameter reference="Metabolite_169"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1193">
              <SourceParameter reference="Metabolite_159"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1194">
              <SourceParameter reference="Metabolite_157"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1195">
              <SourceParameter reference="Metabolite_167"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_139" name="UDP-glucose 4-epimerase (H01)" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_157" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_159" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_327" name="GALE_k_udpgal" value="0.3"/>
          <Constant key="Parameter_328" name="GALE_k_udpglc" value="0.069"/>
          <Constant key="Parameter_329" name="GALE_keq" value="0.33"/>
          <Constant key="Parameter_330" name="H01__GALE_Vmax" value="2.61209e-15"/>
        </ListOfConstants>
        <KineticLaw function="Function_178">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_1180">
              <SourceParameter reference="ModelValue_102"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1177">
              <SourceParameter reference="ModelValue_101"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1175">
              <SourceParameter reference="ModelValue_100"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1173">
              <SourceParameter reference="Compartment_25"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_264">
              <SourceParameter reference="ModelValue_104"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1179">
              <SourceParameter reference="Metabolite_159"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1178">
              <SourceParameter reference="Metabolite_157"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_140" name="UDP-glucose pyrophosphorylase (H01)" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_151" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_167" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_157" stoichiometry="1"/>
          <Product metabolite="Metabolite_173" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_331" name="H01__UGP_Vmax" value="1.74e-11"/>
          <Constant key="Parameter_332" name="H01__UGP_dm" value="10.1849"/>
          <Constant key="Parameter_333" name="UGP_k_glc1p" value="0.172"/>
          <Constant key="Parameter_334" name="UGP_k_utp" value="0.563"/>
          <Constant key="Parameter_335" name="UGP_keq" value="0.45"/>
        </ListOfConstants>
        <KineticLaw function="Function_179">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_1220">
              <SourceParameter reference="Compartment_25"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1221">
              <SourceParameter reference="ModelValue_117"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1222">
              <SourceParameter reference="ModelValue_118"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1223">
              <SourceParameter reference="Metabolite_151"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1224">
              <SourceParameter reference="Metabolite_173"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1225">
              <SourceParameter reference="Metabolite_157"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1226">
              <SourceParameter reference="Metabolite_167"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1227">
              <SourceParameter reference="ModelValue_109"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1228">
              <SourceParameter reference="ModelValue_108"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1229">
              <SourceParameter reference="ModelValue_107"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_141" name="UDP-galactose pyrophosphorylase (H01)" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_155" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_167" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_159" stoichiometry="1"/>
          <Product metabolite="Metabolite_173" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_336" name="H01__UGP_Vmax" value="1.74e-11"/>
          <Constant key="Parameter_337" name="H01__UGP_dm" value="10.1849"/>
          <Constant key="Parameter_338" name="UGALP_f" value="0.01"/>
          <Constant key="Parameter_339" name="UGP_k_gal1p" value="5"/>
          <Constant key="Parameter_340" name="UGP_k_utp" value="0.563"/>
          <Constant key="Parameter_341" name="UGP_keq" value="0.45"/>
        </ListOfConstants>
        <KineticLaw function="Function_180">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_1241">
              <SourceParameter reference="Compartment_25"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1242">
              <SourceParameter reference="ModelValue_117"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1243">
              <SourceParameter reference="ModelValue_118"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1244">
              <SourceParameter reference="Metabolite_155"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1245">
              <SourceParameter reference="Metabolite_173"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1246">
              <SourceParameter reference="Metabolite_159"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1247">
              <SourceParameter reference="Metabolite_167"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1248">
              <SourceParameter reference="ModelValue_106"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1249">
              <SourceParameter reference="ModelValue_112"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1250">
              <SourceParameter reference="ModelValue_108"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1251">
              <SourceParameter reference="ModelValue_107"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_142" name="Pyrophosphatase (H01)" reversible="false" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_173" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_171" stoichiometry="2"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_342" name="H01__PPASE_Vmax" value="8.7e-13"/>
          <Constant key="Parameter_343" name="PPASE_k_ppi" value="0.07"/>
          <Constant key="Parameter_344" name="PPASE_n" value="4"/>
        </ListOfConstants>
        <KineticLaw function="Function_181">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_1140">
              <SourceParameter reference="Compartment_25"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1218">
              <SourceParameter reference="ModelValue_123"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1118">
              <SourceParameter reference="Metabolite_173"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1219">
              <SourceParameter reference="ModelValue_120"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1174">
              <SourceParameter reference="ModelValue_121"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_143" name="ATP:UDP phosphotransferase (H01)" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_163" stoichiometry="1"/>
          <Substrate metabolite="Metabolite_169" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_165" stoichiometry="1"/>
          <Product metabolite="Metabolite_167" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_345" name="H01__NDKU_Vmax" value="3.48e-11"/>
          <Constant key="Parameter_346" name="NDKU_k_adp" value="0.042"/>
          <Constant key="Parameter_347" name="NDKU_k_atp" value="1.33"/>
          <Constant key="Parameter_348" name="NDKU_k_udp" value="0.19"/>
          <Constant key="Parameter_349" name="NDKU_k_utp" value="27"/>
          <Constant key="Parameter_350" name="NDKU_keq" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_182">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_1273">
              <SourceParameter reference="Compartment_25"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1274">
              <SourceParameter reference="ModelValue_131"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1275">
              <SourceParameter reference="Metabolite_165"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1276">
              <SourceParameter reference="Metabolite_163"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1277">
              <SourceParameter reference="Metabolite_169"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1278">
              <SourceParameter reference="Metabolite_167"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1279">
              <SourceParameter reference="ModelValue_127"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1280">
              <SourceParameter reference="ModelValue_126"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1281">
              <SourceParameter reference="ModelValue_129"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1282">
              <SourceParameter reference="ModelValue_128"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1283">
              <SourceParameter reference="ModelValue_125"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_144" name="Phosphoglucomutase-1 (H01)" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_151" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_153" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_351" name="H01__PGM1_Vmax" value="4.35e-13"/>
          <Constant key="Parameter_352" name="PGM1_k_glc1p" value="0.045"/>
          <Constant key="Parameter_353" name="PGM1_k_glc6p" value="0.67"/>
          <Constant key="Parameter_354" name="PGM1_keq" value="10"/>
        </ListOfConstants>
        <KineticLaw function="Function_183">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_1119">
              <SourceParameter reference="Compartment_25"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1267">
              <SourceParameter reference="ModelValue_137"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1120">
              <SourceParameter reference="Metabolite_151"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1272">
              <SourceParameter reference="Metabolite_153"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1295">
              <SourceParameter reference="ModelValue_135"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1296">
              <SourceParameter reference="ModelValue_134"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1297">
              <SourceParameter reference="ModelValue_133"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_145" name="Glycolysis (H01)" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_153" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_171" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_355" name="GLY_k_glc6p" value="0.12"/>
          <Constant key="Parameter_356" name="GLY_k_p" value="0.2"/>
          <Constant key="Parameter_357" name="H01__GLY_Vmax" value="4.35e-14"/>
        </ListOfConstants>
        <KineticLaw function="Function_184">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_1071">
              <SourceParameter reference="ModelValue_139"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1305">
              <SourceParameter reference="ModelValue_140"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1306">
              <SourceParameter reference="Compartment_25"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1307">
              <SourceParameter reference="ModelValue_142"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1308">
              <SourceParameter reference="Metabolite_153"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1309">
              <SourceParameter reference="Metabolite_171"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_146" name="Glycosyltransferase galactose (H01)" reversible="false" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_159" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_169" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_358" name="GTF_k_udpgal" value="0.1"/>
          <Constant key="Parameter_359" name="H01__GTF_Vmax" value="1.74e-16"/>
        </ListOfConstants>
        <KineticLaw function="Function_185">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_1176">
              <SourceParameter reference="ModelValue_144"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1271">
              <SourceParameter reference="Compartment_25"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1316">
              <SourceParameter reference="ModelValue_147"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1317">
              <SourceParameter reference="Metabolite_159"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_147" name="Glycosyltransferase glucose (H01)" reversible="false" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_157" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_169" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_360" name="GTF_k_udpglc" value="0.1"/>
          <Constant key="Parameter_361" name="H01__GTF_Vmax" value="1.74e-16"/>
        </ListOfConstants>
        <KineticLaw function="Function_186">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_1322">
              <SourceParameter reference="ModelValue_145"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1323">
              <SourceParameter reference="Compartment_25"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1324">
              <SourceParameter reference="ModelValue_147"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1325">
              <SourceParameter reference="Metabolite_157"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_148" name="galactose transport" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_77" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_145" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_362" name="GLUT2_k_gal" value="85.5"/>
          <Constant key="Parameter_363" name="H01__GLUT2_Vmax" value="1e-08"/>
          <Constant key="Parameter_364" name="H01__GLUT2_dm" value="1"/>
          <Constant key="Parameter_365" name="Nf" value="5"/>
        </ListOfConstants>
        <KineticLaw function="Function_187">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_1332">
              <SourceParameter reference="Metabolite_77"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1333">
              <SourceParameter reference="ModelValue_149"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1334">
              <SourceParameter reference="ModelValue_151"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1335">
              <SourceParameter reference="ModelValue_152"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1336">
              <SourceParameter reference="Metabolite_145"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1337">
              <SourceParameter reference="ModelValue_6"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_149" name="galactose transport_2" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_101" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_147" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_366" name="GLUT2_k_gal" value="85.5"/>
          <Constant key="Parameter_367" name="H01__GLUT2_Vmax" value="1e-08"/>
          <Constant key="Parameter_368" name="H01__GLUT2_dm" value="1"/>
          <Constant key="Parameter_369" name="Nf" value="5"/>
        </ListOfConstants>
        <KineticLaw function="Function_188">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_1344">
              <SourceParameter reference="Metabolite_101"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1345">
              <SourceParameter reference="ModelValue_149"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1346">
              <SourceParameter reference="ModelValue_151"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1347">
              <SourceParameter reference="ModelValue_152"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1348">
              <SourceParameter reference="Metabolite_147"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1349">
              <SourceParameter reference="ModelValue_6"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_150" name="galactose transport_3" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_81" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_145" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_370" name="GLUT2_k_gal" value="85.5"/>
          <Constant key="Parameter_371" name="H01__GLUT2_Vmax" value="1e-08"/>
          <Constant key="Parameter_372" name="H01__GLUT2_dm" value="1"/>
          <Constant key="Parameter_373" name="Nf" value="5"/>
        </ListOfConstants>
        <KineticLaw function="Function_189">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_1356">
              <SourceParameter reference="Metabolite_81"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1357">
              <SourceParameter reference="ModelValue_149"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1358">
              <SourceParameter reference="ModelValue_151"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1359">
              <SourceParameter reference="ModelValue_152"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1360">
              <SourceParameter reference="Metabolite_145"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1361">
              <SourceParameter reference="ModelValue_6"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_151" name="galactose transport_4" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_105" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_147" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_374" name="GLUT2_k_gal" value="85.5"/>
          <Constant key="Parameter_375" name="H01__GLUT2_Vmax" value="1e-08"/>
          <Constant key="Parameter_376" name="H01__GLUT2_dm" value="1"/>
          <Constant key="Parameter_377" name="Nf" value="5"/>
        </ListOfConstants>
        <KineticLaw function="Function_190">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_1368">
              <SourceParameter reference="Metabolite_105"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1369">
              <SourceParameter reference="ModelValue_149"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1370">
              <SourceParameter reference="ModelValue_151"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1371">
              <SourceParameter reference="ModelValue_152"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1372">
              <SourceParameter reference="Metabolite_147"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1373">
              <SourceParameter reference="ModelValue_6"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_152" name="galactose transport_5" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_85" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_145" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_378" name="GLUT2_k_gal" value="85.5"/>
          <Constant key="Parameter_379" name="H01__GLUT2_Vmax" value="1e-08"/>
          <Constant key="Parameter_380" name="H01__GLUT2_dm" value="1"/>
          <Constant key="Parameter_381" name="Nf" value="5"/>
        </ListOfConstants>
        <KineticLaw function="Function_191">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_1380">
              <SourceParameter reference="Metabolite_85"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1381">
              <SourceParameter reference="ModelValue_149"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1382">
              <SourceParameter reference="ModelValue_151"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1383">
              <SourceParameter reference="ModelValue_152"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1384">
              <SourceParameter reference="Metabolite_145"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1385">
              <SourceParameter reference="ModelValue_6"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_153" name="galactose transport_6" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_109" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_147" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_382" name="GLUT2_k_gal" value="85.5"/>
          <Constant key="Parameter_383" name="H01__GLUT2_Vmax" value="1e-08"/>
          <Constant key="Parameter_384" name="H01__GLUT2_dm" value="1"/>
          <Constant key="Parameter_385" name="Nf" value="5"/>
        </ListOfConstants>
        <KineticLaw function="Function_192">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_1392">
              <SourceParameter reference="Metabolite_109"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1393">
              <SourceParameter reference="ModelValue_149"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1394">
              <SourceParameter reference="ModelValue_151"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1395">
              <SourceParameter reference="ModelValue_152"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1396">
              <SourceParameter reference="Metabolite_147"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1397">
              <SourceParameter reference="ModelValue_6"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_154" name="galactose transport_7" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_89" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_145" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_386" name="GLUT2_k_gal" value="85.5"/>
          <Constant key="Parameter_387" name="H01__GLUT2_Vmax" value="1e-08"/>
          <Constant key="Parameter_388" name="H01__GLUT2_dm" value="1"/>
          <Constant key="Parameter_389" name="Nf" value="5"/>
        </ListOfConstants>
        <KineticLaw function="Function_193">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_1404">
              <SourceParameter reference="Metabolite_89"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1405">
              <SourceParameter reference="ModelValue_149"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1406">
              <SourceParameter reference="ModelValue_151"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1407">
              <SourceParameter reference="ModelValue_152"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1408">
              <SourceParameter reference="Metabolite_145"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1409">
              <SourceParameter reference="ModelValue_6"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_155" name="galactose transport_8" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_113" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_147" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_390" name="GLUT2_k_gal" value="85.5"/>
          <Constant key="Parameter_391" name="H01__GLUT2_Vmax" value="1e-08"/>
          <Constant key="Parameter_392" name="H01__GLUT2_dm" value="1"/>
          <Constant key="Parameter_393" name="Nf" value="5"/>
        </ListOfConstants>
        <KineticLaw function="Function_194">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_1416">
              <SourceParameter reference="Metabolite_113"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1417">
              <SourceParameter reference="ModelValue_149"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1418">
              <SourceParameter reference="ModelValue_151"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1419">
              <SourceParameter reference="ModelValue_152"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1420">
              <SourceParameter reference="Metabolite_147"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1421">
              <SourceParameter reference="ModelValue_6"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_156" name="galactose transport_9" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_93" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_145" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_394" name="GLUT2_k_gal" value="85.5"/>
          <Constant key="Parameter_395" name="H01__GLUT2_Vmax" value="1e-08"/>
          <Constant key="Parameter_396" name="H01__GLUT2_dm" value="1"/>
          <Constant key="Parameter_397" name="Nf" value="5"/>
        </ListOfConstants>
        <KineticLaw function="Function_195">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_1428">
              <SourceParameter reference="Metabolite_93"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1429">
              <SourceParameter reference="ModelValue_149"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1430">
              <SourceParameter reference="ModelValue_151"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1431">
              <SourceParameter reference="ModelValue_152"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1432">
              <SourceParameter reference="Metabolite_145"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1433">
              <SourceParameter reference="ModelValue_6"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_157" name="galactose transport_10" reversible="true" fast="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_117" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_147" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_398" name="GLUT2_k_gal" value="85.5"/>
          <Constant key="Parameter_399" name="H01__GLUT2_Vmax" value="1e-08"/>
          <Constant key="Parameter_400" name="H01__GLUT2_dm" value="1"/>
          <Constant key="Parameter_401" name="Nf" value="5"/>
        </ListOfConstants>
        <KineticLaw function="Function_196">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_1440">
              <SourceParameter reference="Metabolite_117"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1441">
              <SourceParameter reference="ModelValue_149"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1442">
              <SourceParameter reference="ModelValue_151"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1443">
              <SourceParameter reference="ModelValue_152"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1444">
              <SourceParameter reference="Metabolite_147"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_1445">
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
      <Event key="Event_24" name="EGAL_1" fireAtInitialTime="0" persistentTrigger="0">
        <TriggerExpression>
          &lt;CN=Root,Model=NoName,Reference=Time&gt; eq 10800
        </TriggerExpression>
        <ListOfAssignments>
          <Assignment targetKey="Metabolite_73">
            <Expression>
              2
            </Expression>
          </Assignment>
        </ListOfAssignments>
      </Event>
      <Event key="Event_25" name="EGAL_2" fireAtInitialTime="0" persistentTrigger="0">
        <TriggerExpression>
          &lt;CN=Root,Model=NoName,Reference=Time&gt; eq 11400
        </TriggerExpression>
        <ListOfAssignments>
          <Assignment targetKey="Metabolite_73">
            <Expression>
              0.00012
            </Expression>
          </Assignment>
        </ListOfAssignments>
      </Event>
    </ListOfEvents>
    <StateTemplate>
      <StateTemplateVariable objectReference="Model_3"/>
      <StateTemplateVariable objectReference="Metabolite_145"/>
      <StateTemplateVariable objectReference="Metabolite_171"/>
      <StateTemplateVariable objectReference="Metabolite_147"/>
      <StateTemplateVariable objectReference="Metabolite_75"/>
      <StateTemplateVariable objectReference="Metabolite_99"/>
      <StateTemplateVariable objectReference="Metabolite_123"/>
      <StateTemplateVariable objectReference="Metabolite_7"/>
      <StateTemplateVariable objectReference="Metabolite_31"/>
      <StateTemplateVariable objectReference="Metabolite_55"/>
      <StateTemplateVariable objectReference="Metabolite_83"/>
      <StateTemplateVariable objectReference="Metabolite_107"/>
      <StateTemplateVariable objectReference="Metabolite_131"/>
      <StateTemplateVariable objectReference="Metabolite_15"/>
      <StateTemplateVariable objectReference="Metabolite_39"/>
      <StateTemplateVariable objectReference="Metabolite_63"/>
      <StateTemplateVariable objectReference="Metabolite_91"/>
      <StateTemplateVariable objectReference="Metabolite_115"/>
      <StateTemplateVariable objectReference="Metabolite_139"/>
      <StateTemplateVariable objectReference="Metabolite_155"/>
      <StateTemplateVariable objectReference="Metabolite_19"/>
      <StateTemplateVariable objectReference="Metabolite_43"/>
      <StateTemplateVariable objectReference="Metabolite_67"/>
      <StateTemplateVariable objectReference="Metabolite_51"/>
      <StateTemplateVariable objectReference="Metabolite_27"/>
      <StateTemplateVariable objectReference="Metabolite_3"/>
      <StateTemplateVariable objectReference="Metabolite_89"/>
      <StateTemplateVariable objectReference="Metabolite_81"/>
      <StateTemplateVariable objectReference="Metabolite_113"/>
      <StateTemplateVariable objectReference="Metabolite_105"/>
      <StateTemplateVariable objectReference="Metabolite_157"/>
      <StateTemplateVariable objectReference="Metabolite_135"/>
      <StateTemplateVariable objectReference="Metabolite_127"/>
      <StateTemplateVariable objectReference="Metabolite_79"/>
      <StateTemplateVariable objectReference="Metabolite_111"/>
      <StateTemplateVariable objectReference="Metabolite_35"/>
      <StateTemplateVariable objectReference="Metabolite_11"/>
      <StateTemplateVariable objectReference="Metabolite_59"/>
      <StateTemplateVariable objectReference="Metabolite_87"/>
      <StateTemplateVariable objectReference="Metabolite_103"/>
      <StateTemplateVariable objectReference="Metabolite_163"/>
      <StateTemplateVariable objectReference="Metabolite_137"/>
      <StateTemplateVariable objectReference="Metabolite_17"/>
      <StateTemplateVariable objectReference="Metabolite_41"/>
      <StateTemplateVariable objectReference="Metabolite_65"/>
      <StateTemplateVariable objectReference="Metabolite_33"/>
      <StateTemplateVariable objectReference="Metabolite_57"/>
      <StateTemplateVariable objectReference="Metabolite_9"/>
      <StateTemplateVariable objectReference="Metabolite_129"/>
      <StateTemplateVariable objectReference="Metabolite_85"/>
      <StateTemplateVariable objectReference="Metabolite_109"/>
      <StateTemplateVariable objectReference="Metabolite_169"/>
      <StateTemplateVariable objectReference="Metabolite_47"/>
      <StateTemplateVariable objectReference="Metabolite_71"/>
      <StateTemplateVariable objectReference="Metabolite_23"/>
      <StateTemplateVariable objectReference="Metabolite_143"/>
      <StateTemplateVariable objectReference="Metabolite_95"/>
      <StateTemplateVariable objectReference="Metabolite_119"/>
      <StateTemplateVariable objectReference="Metabolite_77"/>
      <StateTemplateVariable objectReference="Metabolite_151"/>
      <StateTemplateVariable objectReference="Metabolite_175"/>
      <StateTemplateVariable objectReference="Metabolite_101"/>
      <StateTemplateVariable objectReference="Metabolite_61"/>
      <StateTemplateVariable objectReference="Metabolite_133"/>
      <StateTemplateVariable objectReference="Metabolite_37"/>
      <StateTemplateVariable objectReference="Metabolite_13"/>
      <StateTemplateVariable objectReference="Metabolite_167"/>
      <StateTemplateVariable objectReference="Metabolite_93"/>
      <StateTemplateVariable objectReference="Metabolite_153"/>
      <StateTemplateVariable objectReference="Metabolite_117"/>
      <StateTemplateVariable objectReference="Metabolite_5"/>
      <StateTemplateVariable objectReference="Metabolite_29"/>
      <StateTemplateVariable objectReference="Metabolite_125"/>
      <StateTemplateVariable objectReference="Metabolite_53"/>
      <StateTemplateVariable objectReference="Metabolite_69"/>
      <StateTemplateVariable objectReference="Metabolite_21"/>
      <StateTemplateVariable objectReference="Metabolite_45"/>
      <StateTemplateVariable objectReference="Metabolite_141"/>
      <StateTemplateVariable objectReference="Metabolite_161"/>
      <StateTemplateVariable objectReference="Metabolite_159"/>
      <StateTemplateVariable objectReference="Metabolite_173"/>
      <StateTemplateVariable objectReference="Metabolite_165"/>
      <StateTemplateVariable objectReference="Metabolite_177"/>
      <StateTemplateVariable objectReference="Compartment_1"/>
      <StateTemplateVariable objectReference="Compartment_3"/>
      <StateTemplateVariable objectReference="Compartment_5"/>
      <StateTemplateVariable objectReference="Compartment_7"/>
      <StateTemplateVariable objectReference="Compartment_9"/>
      <StateTemplateVariable objectReference="Compartment_11"/>
      <StateTemplateVariable objectReference="Compartment_13"/>
      <StateTemplateVariable objectReference="Compartment_15"/>
      <StateTemplateVariable objectReference="Compartment_17"/>
      <StateTemplateVariable objectReference="Compartment_19"/>
      <StateTemplateVariable objectReference="Compartment_21"/>
      <StateTemplateVariable objectReference="Compartment_23"/>
      <StateTemplateVariable objectReference="Compartment_25"/>
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
      <StateTemplateVariable objectReference="ModelValue_20"/>
      <StateTemplateVariable objectReference="ModelValue_21"/>
      <StateTemplateVariable objectReference="ModelValue_23"/>
      <StateTemplateVariable objectReference="ModelValue_24"/>
      <StateTemplateVariable objectReference="ModelValue_25"/>
      <StateTemplateVariable objectReference="ModelValue_27"/>
      <StateTemplateVariable objectReference="ModelValue_28"/>
      <StateTemplateVariable objectReference="ModelValue_29"/>
      <StateTemplateVariable objectReference="ModelValue_31"/>
      <StateTemplateVariable objectReference="ModelValue_32"/>
      <StateTemplateVariable objectReference="ModelValue_33"/>
      <StateTemplateVariable objectReference="ModelValue_35"/>
      <StateTemplateVariable objectReference="ModelValue_36"/>
      <StateTemplateVariable objectReference="ModelValue_37"/>
      <StateTemplateVariable objectReference="ModelValue_39"/>
      <StateTemplateVariable objectReference="ModelValue_40"/>
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
      <StateTemplateVariable objectReference="ModelValue_7"/>
      <StateTemplateVariable objectReference="ModelValue_46"/>
      <StateTemplateVariable objectReference="ModelValue_47"/>
      <StateTemplateVariable objectReference="ModelValue_48"/>
      <StateTemplateVariable objectReference="ModelValue_49"/>
      <StateTemplateVariable objectReference="ModelValue_153"/>
      <StateTemplateVariable objectReference="ModelValue_154"/>
      <StateTemplateVariable objectReference="Metabolite_1"/>
      <StateTemplateVariable objectReference="Metabolite_25"/>
      <StateTemplateVariable objectReference="Metabolite_49"/>
      <StateTemplateVariable objectReference="Metabolite_73"/>
      <StateTemplateVariable objectReference="Metabolite_97"/>
      <StateTemplateVariable objectReference="Metabolite_121"/>
      <StateTemplateVariable objectReference="Metabolite_149"/>
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
    </StateTemplate>
    <InitialState type="initialState">
      0 11812623.30620859 492192637758.6914 0 439528.912352093 0 0 0 0 0 439528.912352093 0 0 0 0 0 439528.912352093 0 0 98438527.55173828 0 0 0 0 0 0 174358.5768008303 174358.5768008303 0 0 33469099367.59102 0 0 439528.912352093 0 0 0 0 439528.912352093 0 265784024389.6934 0 0 0 0 0 0 0 0 174358.5768008303 0 8859467479.656445 0 0 0 0 439528.912352093 0 174358.5768008303 1181262330.620859 9843852755.17383 0 0 0 0 0 26578402438.96934 174358.5768008303 11812623306.20859 0 0 0 0 0 0 0 0 0 98438527.55173828 10828238030.69121 787508220.4139062 118126233062.0859 9843852755.17383 6.08212337734984e-14 6.08212337734984e-15 2.412743157956961e-15 6.08212337734984e-15 2.412743157956961e-15 6.08212337734984e-15 2.412743157956961e-15 6.08212337734984e-15 2.412743157956961e-15 6.08212337734984e-15 2.412743157956961e-15 6.08212337734984e-15 1.63460992757094e-13 0.0005 0.0001 6.08212337734984e-11 2.412743157956961e-11 2.764601535159018e-09 6.08212337734984e-15 2.412743157956961e-15 1.63460992757094e-13 6.08212337734984e-14 6.08212337734984e-15 0 0 0 2.432849350939936e-16 9.650972631827844e-17 1.382300767579509e-12 6.08212337734984e-17 2.412743157956961e-17 3.455751918948773e-13 2.432849350939936e-16 9.650972631827844e-17 1.382300767579509e-12 2.432849350939936e-16 9.650972631827844e-17 1.382300767579509e-12 1.216424675469968e-15 4.825486315913922e-16 6.911503837897545e-12 1e-14 8.7e-15 81.92337921972911 4.35e-16 8.7e-13 8.7e-09 8.7e-19 6.9948e-14 2.612088e-15 1.74e-11 10.18490079862424 8.7e-13 3.48e-11 4.35e-13 4.35e-14 1.74e-16 1e-08 1.000002807017544 5 0.2 3.9 0.8100000000000001 17.539 0 0 0 0 0 4395289.123520929 0 0 0 0.0005 4.4e-06 8e-07 6.25e-06 6e-05 1 5 0 4e-10 1e-10 4e-10 4e-10 2e-09 1e-14 1 0 0.1 50 1.5 0.8 5.3 8.699999999999999 0.97 0.034 1 0.05 0.35 1 100 0.58 0.1 0.5 0.1 1 1000000 4 40 40 0.1 0.1 1 1e-10 1 0.015 0.01 1 0.01 1 0.37 0.5 0.13 0.35 804 1.25 0.43 1 0.3 0.0278 36 0.33 0.06900000000000001 0.3 1 2000 0.01 0.45 0.5629999999999999 0.172 0.049 0.166 5 0.42 0.643 0.643 1 0.05 0.07000000000000001 4 1 2 1 1.33 0.042 27 0.19 1 50 10 0.67 0.045 1 0.1 0.12 0.2 1 0.02 0.1 0.1 1 1000000 85.5 1 
    </InitialState>
  </Model>
  <ListOfTasks>
    <Task key="Task_14" name="Steady-State" type="steadyState" scheduled="false" updateModel="false">
      <Report reference="Report_9" target="" append="1" confirmOverwrite="1"/>
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
    <Task key="Task_15" name="Time-Course" type="timeCourse" scheduled="false" updateModel="false">
      <Problem>
        <Parameter name="StepNumber" type="unsignedInteger" value="100"/>
        <Parameter name="StepSize" type="float" value="0.01"/>
        <Parameter name="Duration" type="float" value="1"/>
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
    <Task key="Task_16" name="Scan" type="scan" scheduled="false" updateModel="false">
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
    <Task key="Task_17" name="Elementary Flux Modes" type="fluxMode" scheduled="false" updateModel="false">
      <Report reference="Report_10" target="" append="1" confirmOverwrite="1"/>
      <Problem>
      </Problem>
      <Method name="EFM Algorithm" type="EFMAlgorithm">
      </Method>
    </Task>
    <Task key="Task_18" name="Optimization" type="optimization" scheduled="false" updateModel="false">
      <Report reference="Report_11" target="" append="1" confirmOverwrite="1"/>
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
    <Task key="Task_19" name="Parameter Estimation" type="parameterFitting" scheduled="false" updateModel="false">
      <Report reference="Report_12" target="" append="1" confirmOverwrite="1"/>
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
    <Task key="Task_20" name="Metabolic Control Analysis" type="metabolicControlAnalysis" scheduled="false" updateModel="false">
      <Report reference="Report_13" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="Steady-State" type="key" value="Task_14"/>
      </Problem>
      <Method name="MCA Method (Reder)" type="MCAMethod(Reder)">
        <Parameter name="Modulation Factor" type="unsignedFloat" value="1e-09"/>
      </Method>
    </Task>
    <Task key="Task_21" name="Lyapunov Exponents" type="lyapunovExponents" scheduled="false" updateModel="false">
      <Report reference="Report_14" target="" append="1" confirmOverwrite="1"/>
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
    <Task key="Task_22" name="Time Scale Separation Analysis" type="timeScaleSeparationAnalysis" scheduled="false" updateModel="false">
      <Report reference="Report_15" target="" append="1" confirmOverwrite="1"/>
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
    <Task key="Task_23" name="Sensitivities" type="sensitivities" scheduled="false" updateModel="false">
      <Report reference="Report_16" target="" append="1" confirmOverwrite="1"/>
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
    <Task key="Task_24" name="Moieties" type="moieties" scheduled="false" updateModel="false">
      <Problem>
      </Problem>
      <Method name="Householder Reduction" type="Householder">
      </Method>
    </Task>
    <Task key="Task_25" name="Cross Section" type="crosssection" scheduled="false" updateModel="false">
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
    <Task key="Task_26" name="Linear Noise Approximation" type="linearNoiseApproximation" scheduled="false" updateModel="false">
      <Report reference="Report_17" target="" append="1" confirmOverwrite="1"/>
      <Problem>
        <Parameter name="Steady-State" type="key" value="Task_14"/>
      </Problem>
      <Method name="Linear Noise Approximation" type="LinearNoiseApproximation">
      </Method>
    </Task>
  </ListOfTasks>
  <ListOfReports>
    <Report key="Report_9" name="Steady-State" taskType="steadyState" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Footer>
        <Object cn="CN=Root,Vector=TaskList[Steady-State]"/>
      </Footer>
    </Report>
    <Report key="Report_10" name="Elementary Flux Modes" taskType="fluxMode" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Footer>
        <Object cn="CN=Root,Vector=TaskList[Elementary Flux Modes],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_11" name="Optimization" taskType="optimization" separator="&#x09;" precision="6">
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
    <Report key="Report_12" name="Parameter Estimation" taskType="parameterFitting" separator="&#x09;" precision="6">
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
    <Report key="Report_14" name="Lyapunov Exponents" taskType="lyapunovExponents" separator="&#x09;" precision="6">
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
    <Report key="Report_15" name="Time Scale Separation Analysis" taskType="timeScaleSeparationAnalysis" separator="&#x09;" precision="6">
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
    <Report key="Report_16" name="Sensitivities" taskType="sensitivities" separator="&#x09;" precision="6">
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
    <Report key="Report_17" name="Linear Noise Approximation" taskType="linearNoiseApproximation" separator="&#x09;" precision="6">
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
  <SBMLReference file="Galactose_v3_Nc1_Nf5.xml">
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
    <SBMLMap SBMLid="D001" COPASIkey="Compartment_5"/>
    <SBMLMap SBMLid="D001__GLUT2_GAL" COPASIkey="Reaction_148"/>
    <SBMLMap SBMLid="D001__GLUT2_GALM" COPASIkey="Reaction_149"/>
    <SBMLMap SBMLid="D001__alb" COPASIkey="Metabolite_53"/>
    <SBMLMap SBMLid="D001__gal" COPASIkey="Metabolite_77"/>
    <SBMLMap SBMLid="D001__galM" COPASIkey="Metabolite_101"/>
    <SBMLMap SBMLid="D001__h2oM" COPASIkey="Metabolite_125"/>
    <SBMLMap SBMLid="D001__rbcM" COPASIkey="Metabolite_5"/>
    <SBMLMap SBMLid="D001__suc" COPASIkey="Metabolite_29"/>
    <SBMLMap SBMLid="D002" COPASIkey="Compartment_9"/>
    <SBMLMap SBMLid="D002__GLUT2_GAL" COPASIkey="Reaction_150"/>
    <SBMLMap SBMLid="D002__GLUT2_GALM" COPASIkey="Reaction_151"/>
    <SBMLMap SBMLid="D002__alb" COPASIkey="Metabolite_57"/>
    <SBMLMap SBMLid="D002__gal" COPASIkey="Metabolite_81"/>
    <SBMLMap SBMLid="D002__galM" COPASIkey="Metabolite_105"/>
    <SBMLMap SBMLid="D002__h2oM" COPASIkey="Metabolite_129"/>
    <SBMLMap SBMLid="D002__rbcM" COPASIkey="Metabolite_9"/>
    <SBMLMap SBMLid="D002__suc" COPASIkey="Metabolite_33"/>
    <SBMLMap SBMLid="D003" COPASIkey="Compartment_13"/>
    <SBMLMap SBMLid="D003__GLUT2_GAL" COPASIkey="Reaction_152"/>
    <SBMLMap SBMLid="D003__GLUT2_GALM" COPASIkey="Reaction_153"/>
    <SBMLMap SBMLid="D003__alb" COPASIkey="Metabolite_61"/>
    <SBMLMap SBMLid="D003__gal" COPASIkey="Metabolite_85"/>
    <SBMLMap SBMLid="D003__galM" COPASIkey="Metabolite_109"/>
    <SBMLMap SBMLid="D003__h2oM" COPASIkey="Metabolite_133"/>
    <SBMLMap SBMLid="D003__rbcM" COPASIkey="Metabolite_13"/>
    <SBMLMap SBMLid="D003__suc" COPASIkey="Metabolite_37"/>
    <SBMLMap SBMLid="D004" COPASIkey="Compartment_17"/>
    <SBMLMap SBMLid="D004__GLUT2_GAL" COPASIkey="Reaction_154"/>
    <SBMLMap SBMLid="D004__GLUT2_GALM" COPASIkey="Reaction_155"/>
    <SBMLMap SBMLid="D004__alb" COPASIkey="Metabolite_65"/>
    <SBMLMap SBMLid="D004__gal" COPASIkey="Metabolite_89"/>
    <SBMLMap SBMLid="D004__galM" COPASIkey="Metabolite_113"/>
    <SBMLMap SBMLid="D004__h2oM" COPASIkey="Metabolite_137"/>
    <SBMLMap SBMLid="D004__rbcM" COPASIkey="Metabolite_17"/>
    <SBMLMap SBMLid="D004__suc" COPASIkey="Metabolite_41"/>
    <SBMLMap SBMLid="D005" COPASIkey="Compartment_21"/>
    <SBMLMap SBMLid="D005__GLUT2_GAL" COPASIkey="Reaction_156"/>
    <SBMLMap SBMLid="D005__GLUT2_GALM" COPASIkey="Reaction_157"/>
    <SBMLMap SBMLid="D005__alb" COPASIkey="Metabolite_69"/>
    <SBMLMap SBMLid="D005__gal" COPASIkey="Metabolite_93"/>
    <SBMLMap SBMLid="D005__galM" COPASIkey="Metabolite_117"/>
    <SBMLMap SBMLid="D005__h2oM" COPASIkey="Metabolite_141"/>
    <SBMLMap SBMLid="D005__rbcM" COPASIkey="Metabolite_21"/>
    <SBMLMap SBMLid="D005__suc" COPASIkey="Metabolite_45"/>
    <SBMLMap SBMLid="Dalb" COPASIkey="ModelValue_26"/>
    <SBMLMap SBMLid="Dgal" COPASIkey="ModelValue_30"/>
    <SBMLMap SBMLid="DgalM" COPASIkey="ModelValue_34"/>
    <SBMLMap SBMLid="Dh2oM" COPASIkey="ModelValue_38"/>
    <SBMLMap SBMLid="DiffD001D002_alb" COPASIkey="Reaction_78"/>
    <SBMLMap SBMLid="DiffD001D002_gal" COPASIkey="Reaction_93"/>
    <SBMLMap SBMLid="DiffD001D002_galM" COPASIkey="Reaction_108"/>
    <SBMLMap SBMLid="DiffD001D002_h2oM" COPASIkey="Reaction_123"/>
    <SBMLMap SBMLid="DiffD001D002_rbcM" COPASIkey="Reaction_48"/>
    <SBMLMap SBMLid="DiffD001D002_suc" COPASIkey="Reaction_63"/>
    <SBMLMap SBMLid="DiffD002D003_alb" COPASIkey="Reaction_79"/>
    <SBMLMap SBMLid="DiffD002D003_gal" COPASIkey="Reaction_94"/>
    <SBMLMap SBMLid="DiffD002D003_galM" COPASIkey="Reaction_109"/>
    <SBMLMap SBMLid="DiffD002D003_h2oM" COPASIkey="Reaction_124"/>
    <SBMLMap SBMLid="DiffD002D003_rbcM" COPASIkey="Reaction_49"/>
    <SBMLMap SBMLid="DiffD002D003_suc" COPASIkey="Reaction_64"/>
    <SBMLMap SBMLid="DiffD003D004_alb" COPASIkey="Reaction_80"/>
    <SBMLMap SBMLid="DiffD003D004_gal" COPASIkey="Reaction_95"/>
    <SBMLMap SBMLid="DiffD003D004_galM" COPASIkey="Reaction_110"/>
    <SBMLMap SBMLid="DiffD003D004_h2oM" COPASIkey="Reaction_125"/>
    <SBMLMap SBMLid="DiffD003D004_rbcM" COPASIkey="Reaction_50"/>
    <SBMLMap SBMLid="DiffD003D004_suc" COPASIkey="Reaction_65"/>
    <SBMLMap SBMLid="DiffD004D005_alb" COPASIkey="Reaction_81"/>
    <SBMLMap SBMLid="DiffD004D005_gal" COPASIkey="Reaction_96"/>
    <SBMLMap SBMLid="DiffD004D005_galM" COPASIkey="Reaction_111"/>
    <SBMLMap SBMLid="DiffD004D005_h2oM" COPASIkey="Reaction_126"/>
    <SBMLMap SBMLid="DiffD004D005_rbcM" COPASIkey="Reaction_51"/>
    <SBMLMap SBMLid="DiffD004D005_suc" COPASIkey="Reaction_66"/>
    <SBMLMap SBMLid="DiffPPS001_alb" COPASIkey="Reaction_72"/>
    <SBMLMap SBMLid="DiffPPS001_gal" COPASIkey="Reaction_87"/>
    <SBMLMap SBMLid="DiffPPS001_galM" COPASIkey="Reaction_102"/>
    <SBMLMap SBMLid="DiffPPS001_h2oM" COPASIkey="Reaction_117"/>
    <SBMLMap SBMLid="DiffPPS001_rbcM" COPASIkey="Reaction_42"/>
    <SBMLMap SBMLid="DiffPPS001_suc" COPASIkey="Reaction_57"/>
    <SBMLMap SBMLid="DiffS001D001_alb" COPASIkey="Reaction_82"/>
    <SBMLMap SBMLid="DiffS001D001_gal" COPASIkey="Reaction_97"/>
    <SBMLMap SBMLid="DiffS001D001_galM" COPASIkey="Reaction_112"/>
    <SBMLMap SBMLid="DiffS001D001_h2oM" COPASIkey="Reaction_127"/>
    <SBMLMap SBMLid="DiffS001D001_rbcM" COPASIkey="Reaction_52"/>
    <SBMLMap SBMLid="DiffS001D001_suc" COPASIkey="Reaction_67"/>
    <SBMLMap SBMLid="DiffS001S002_alb" COPASIkey="Reaction_73"/>
    <SBMLMap SBMLid="DiffS001S002_gal" COPASIkey="Reaction_88"/>
    <SBMLMap SBMLid="DiffS001S002_galM" COPASIkey="Reaction_103"/>
    <SBMLMap SBMLid="DiffS001S002_h2oM" COPASIkey="Reaction_118"/>
    <SBMLMap SBMLid="DiffS001S002_rbcM" COPASIkey="Reaction_43"/>
    <SBMLMap SBMLid="DiffS001S002_suc" COPASIkey="Reaction_58"/>
    <SBMLMap SBMLid="DiffS002D002_alb" COPASIkey="Reaction_83"/>
    <SBMLMap SBMLid="DiffS002D002_gal" COPASIkey="Reaction_98"/>
    <SBMLMap SBMLid="DiffS002D002_galM" COPASIkey="Reaction_113"/>
    <SBMLMap SBMLid="DiffS002D002_h2oM" COPASIkey="Reaction_128"/>
    <SBMLMap SBMLid="DiffS002D002_rbcM" COPASIkey="Reaction_53"/>
    <SBMLMap SBMLid="DiffS002D002_suc" COPASIkey="Reaction_68"/>
    <SBMLMap SBMLid="DiffS002S003_alb" COPASIkey="Reaction_74"/>
    <SBMLMap SBMLid="DiffS002S003_gal" COPASIkey="Reaction_89"/>
    <SBMLMap SBMLid="DiffS002S003_galM" COPASIkey="Reaction_104"/>
    <SBMLMap SBMLid="DiffS002S003_h2oM" COPASIkey="Reaction_119"/>
    <SBMLMap SBMLid="DiffS002S003_rbcM" COPASIkey="Reaction_44"/>
    <SBMLMap SBMLid="DiffS002S003_suc" COPASIkey="Reaction_59"/>
    <SBMLMap SBMLid="DiffS003D003_alb" COPASIkey="Reaction_84"/>
    <SBMLMap SBMLid="DiffS003D003_gal" COPASIkey="Reaction_99"/>
    <SBMLMap SBMLid="DiffS003D003_galM" COPASIkey="Reaction_114"/>
    <SBMLMap SBMLid="DiffS003D003_h2oM" COPASIkey="Reaction_129"/>
    <SBMLMap SBMLid="DiffS003D003_rbcM" COPASIkey="Reaction_54"/>
    <SBMLMap SBMLid="DiffS003D003_suc" COPASIkey="Reaction_69"/>
    <SBMLMap SBMLid="DiffS003S004_alb" COPASIkey="Reaction_75"/>
    <SBMLMap SBMLid="DiffS003S004_gal" COPASIkey="Reaction_90"/>
    <SBMLMap SBMLid="DiffS003S004_galM" COPASIkey="Reaction_105"/>
    <SBMLMap SBMLid="DiffS003S004_h2oM" COPASIkey="Reaction_120"/>
    <SBMLMap SBMLid="DiffS003S004_rbcM" COPASIkey="Reaction_45"/>
    <SBMLMap SBMLid="DiffS003S004_suc" COPASIkey="Reaction_60"/>
    <SBMLMap SBMLid="DiffS004D004_alb" COPASIkey="Reaction_85"/>
    <SBMLMap SBMLid="DiffS004D004_gal" COPASIkey="Reaction_100"/>
    <SBMLMap SBMLid="DiffS004D004_galM" COPASIkey="Reaction_115"/>
    <SBMLMap SBMLid="DiffS004D004_h2oM" COPASIkey="Reaction_130"/>
    <SBMLMap SBMLid="DiffS004D004_rbcM" COPASIkey="Reaction_55"/>
    <SBMLMap SBMLid="DiffS004D004_suc" COPASIkey="Reaction_70"/>
    <SBMLMap SBMLid="DiffS004S005_alb" COPASIkey="Reaction_76"/>
    <SBMLMap SBMLid="DiffS004S005_gal" COPASIkey="Reaction_91"/>
    <SBMLMap SBMLid="DiffS004S005_galM" COPASIkey="Reaction_106"/>
    <SBMLMap SBMLid="DiffS004S005_h2oM" COPASIkey="Reaction_121"/>
    <SBMLMap SBMLid="DiffS004S005_rbcM" COPASIkey="Reaction_46"/>
    <SBMLMap SBMLid="DiffS004S005_suc" COPASIkey="Reaction_61"/>
    <SBMLMap SBMLid="DiffS005D005_alb" COPASIkey="Reaction_86"/>
    <SBMLMap SBMLid="DiffS005D005_gal" COPASIkey="Reaction_101"/>
    <SBMLMap SBMLid="DiffS005D005_galM" COPASIkey="Reaction_116"/>
    <SBMLMap SBMLid="DiffS005D005_h2oM" COPASIkey="Reaction_131"/>
    <SBMLMap SBMLid="DiffS005D005_rbcM" COPASIkey="Reaction_56"/>
    <SBMLMap SBMLid="DiffS005D005_suc" COPASIkey="Reaction_71"/>
    <SBMLMap SBMLid="DiffS005PV_alb" COPASIkey="Reaction_77"/>
    <SBMLMap SBMLid="DiffS005PV_gal" COPASIkey="Reaction_92"/>
    <SBMLMap SBMLid="DiffS005PV_galM" COPASIkey="Reaction_107"/>
    <SBMLMap SBMLid="DiffS005PV_h2oM" COPASIkey="Reaction_122"/>
    <SBMLMap SBMLid="DiffS005PV_rbcM" COPASIkey="Reaction_47"/>
    <SBMLMap SBMLid="DiffS005PV_suc" COPASIkey="Reaction_62"/>
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
    <SBMLMap SBMLid="EGAL_1" COPASIkey="Event_24"/>
    <SBMLMap SBMLid="EGAL_2" COPASIkey="Event_25"/>
    <SBMLMap SBMLid="FlowPPS001_alb" COPASIkey="Reaction_14"/>
    <SBMLMap SBMLid="FlowPPS001_gal" COPASIkey="Reaction_21"/>
    <SBMLMap SBMLid="FlowPPS001_galM" COPASIkey="Reaction_28"/>
    <SBMLMap SBMLid="FlowPPS001_h2oM" COPASIkey="Reaction_35"/>
    <SBMLMap SBMLid="FlowPPS001_rbcM" COPASIkey="Reaction_0"/>
    <SBMLMap SBMLid="FlowPPS001_suc" COPASIkey="Reaction_7"/>
    <SBMLMap SBMLid="FlowPVNULL_alb" COPASIkey="Reaction_20"/>
    <SBMLMap SBMLid="FlowPVNULL_gal" COPASIkey="Reaction_27"/>
    <SBMLMap SBMLid="FlowPVNULL_galM" COPASIkey="Reaction_34"/>
    <SBMLMap SBMLid="FlowPVNULL_h2oM" COPASIkey="Reaction_41"/>
    <SBMLMap SBMLid="FlowPVNULL_rbcM" COPASIkey="Reaction_6"/>
    <SBMLMap SBMLid="FlowPVNULL_suc" COPASIkey="Reaction_13"/>
    <SBMLMap SBMLid="FlowS001S002_alb" COPASIkey="Reaction_15"/>
    <SBMLMap SBMLid="FlowS001S002_gal" COPASIkey="Reaction_22"/>
    <SBMLMap SBMLid="FlowS001S002_galM" COPASIkey="Reaction_29"/>
    <SBMLMap SBMLid="FlowS001S002_h2oM" COPASIkey="Reaction_36"/>
    <SBMLMap SBMLid="FlowS001S002_rbcM" COPASIkey="Reaction_1"/>
    <SBMLMap SBMLid="FlowS001S002_suc" COPASIkey="Reaction_8"/>
    <SBMLMap SBMLid="FlowS002S003_alb" COPASIkey="Reaction_16"/>
    <SBMLMap SBMLid="FlowS002S003_gal" COPASIkey="Reaction_23"/>
    <SBMLMap SBMLid="FlowS002S003_galM" COPASIkey="Reaction_30"/>
    <SBMLMap SBMLid="FlowS002S003_h2oM" COPASIkey="Reaction_37"/>
    <SBMLMap SBMLid="FlowS002S003_rbcM" COPASIkey="Reaction_2"/>
    <SBMLMap SBMLid="FlowS002S003_suc" COPASIkey="Reaction_9"/>
    <SBMLMap SBMLid="FlowS003S004_alb" COPASIkey="Reaction_17"/>
    <SBMLMap SBMLid="FlowS003S004_gal" COPASIkey="Reaction_24"/>
    <SBMLMap SBMLid="FlowS003S004_galM" COPASIkey="Reaction_31"/>
    <SBMLMap SBMLid="FlowS003S004_h2oM" COPASIkey="Reaction_38"/>
    <SBMLMap SBMLid="FlowS003S004_rbcM" COPASIkey="Reaction_3"/>
    <SBMLMap SBMLid="FlowS003S004_suc" COPASIkey="Reaction_10"/>
    <SBMLMap SBMLid="FlowS004S005_alb" COPASIkey="Reaction_18"/>
    <SBMLMap SBMLid="FlowS004S005_gal" COPASIkey="Reaction_25"/>
    <SBMLMap SBMLid="FlowS004S005_galM" COPASIkey="Reaction_32"/>
    <SBMLMap SBMLid="FlowS004S005_h2oM" COPASIkey="Reaction_39"/>
    <SBMLMap SBMLid="FlowS004S005_rbcM" COPASIkey="Reaction_4"/>
    <SBMLMap SBMLid="FlowS004S005_suc" COPASIkey="Reaction_11"/>
    <SBMLMap SBMLid="FlowS005PV_alb" COPASIkey="Reaction_19"/>
    <SBMLMap SBMLid="FlowS005PV_gal" COPASIkey="Reaction_26"/>
    <SBMLMap SBMLid="FlowS005PV_galM" COPASIkey="Reaction_33"/>
    <SBMLMap SBMLid="FlowS005PV_h2oM" COPASIkey="Reaction_40"/>
    <SBMLMap SBMLid="FlowS005PV_rbcM" COPASIkey="Reaction_5"/>
    <SBMLMap SBMLid="FlowS005PV_suc" COPASIkey="Reaction_12"/>
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
    <SBMLMap SBMLid="H01" COPASIkey="Compartment_25"/>
    <SBMLMap SBMLid="H01__ALDR" COPASIkey="Reaction_136"/>
    <SBMLMap SBMLid="H01__ALDR_P" COPASIkey="ModelValue_78"/>
    <SBMLMap SBMLid="H01__ALDR_Vmax" COPASIkey="ModelValue_79"/>
    <SBMLMap SBMLid="H01__ATPS" COPASIkey="Reaction_135"/>
    <SBMLMap SBMLid="H01__ATPS_P" COPASIkey="ModelValue_70"/>
    <SBMLMap SBMLid="H01__ATPS_Vmax" COPASIkey="ModelValue_71"/>
    <SBMLMap SBMLid="H01__GALE" COPASIkey="Reaction_139"/>
    <SBMLMap SBMLid="H01__GALE_P" COPASIkey="ModelValue_103"/>
    <SBMLMap SBMLid="H01__GALE_Vmax" COPASIkey="ModelValue_104"/>
    <SBMLMap SBMLid="H01__GALK" COPASIkey="Reaction_132"/>
    <SBMLMap SBMLid="H01__GALKM" COPASIkey="Reaction_133"/>
    <SBMLMap SBMLid="H01__GALK_P" COPASIkey="ModelValue_58"/>
    <SBMLMap SBMLid="H01__GALK_Vmax" COPASIkey="ModelValue_59"/>
    <SBMLMap SBMLid="H01__GALK_dm" COPASIkey="ModelValue_60"/>
    <SBMLMap SBMLid="H01__GALT" COPASIkey="Reaction_138"/>
    <SBMLMap SBMLid="H01__GALT_P" COPASIkey="ModelValue_95"/>
    <SBMLMap SBMLid="H01__GALT_Vmax" COPASIkey="ModelValue_96"/>
    <SBMLMap SBMLid="H01__GLUT2_GAL" COPASIkey="ModelValue_153"/>
    <SBMLMap SBMLid="H01__GLUT2_GALM" COPASIkey="ModelValue_154"/>
    <SBMLMap SBMLid="H01__GLUT2_P" COPASIkey="ModelValue_150"/>
    <SBMLMap SBMLid="H01__GLUT2_Vmax" COPASIkey="ModelValue_151"/>
    <SBMLMap SBMLid="H01__GLUT2_dm" COPASIkey="ModelValue_152"/>
    <SBMLMap SBMLid="H01__GLY" COPASIkey="Reaction_145"/>
    <SBMLMap SBMLid="H01__GLY_P" COPASIkey="ModelValue_141"/>
    <SBMLMap SBMLid="H01__GLY_Vmax" COPASIkey="ModelValue_142"/>
    <SBMLMap SBMLid="H01__GTFGAL" COPASIkey="Reaction_146"/>
    <SBMLMap SBMLid="H01__GTFGLC" COPASIkey="Reaction_147"/>
    <SBMLMap SBMLid="H01__GTF_P" COPASIkey="ModelValue_146"/>
    <SBMLMap SBMLid="H01__GTF_Vmax" COPASIkey="ModelValue_147"/>
    <SBMLMap SBMLid="H01__IMP" COPASIkey="Reaction_134"/>
    <SBMLMap SBMLid="H01__IMP_P" COPASIkey="ModelValue_63"/>
    <SBMLMap SBMLid="H01__IMP_Vmax" COPASIkey="ModelValue_64"/>
    <SBMLMap SBMLid="H01__NADPR" COPASIkey="Reaction_137"/>
    <SBMLMap SBMLid="H01__NADPR_P" COPASIkey="ModelValue_84"/>
    <SBMLMap SBMLid="H01__NADPR_Vmax" COPASIkey="ModelValue_85"/>
    <SBMLMap SBMLid="H01__NDKU" COPASIkey="Reaction_143"/>
    <SBMLMap SBMLid="H01__NDKU_P" COPASIkey="ModelValue_130"/>
    <SBMLMap SBMLid="H01__NDKU_Vmax" COPASIkey="ModelValue_131"/>
    <SBMLMap SBMLid="H01__PGM1" COPASIkey="Reaction_144"/>
    <SBMLMap SBMLid="H01__PGM1_P" COPASIkey="ModelValue_136"/>
    <SBMLMap SBMLid="H01__PGM1_Vmax" COPASIkey="ModelValue_137"/>
    <SBMLMap SBMLid="H01__PPASE" COPASIkey="Reaction_142"/>
    <SBMLMap SBMLid="H01__PPASE_P" COPASIkey="ModelValue_122"/>
    <SBMLMap SBMLid="H01__PPASE_Vmax" COPASIkey="ModelValue_123"/>
    <SBMLMap SBMLid="H01__UGALP" COPASIkey="Reaction_141"/>
    <SBMLMap SBMLid="H01__UGP" COPASIkey="Reaction_140"/>
    <SBMLMap SBMLid="H01__UGP_P" COPASIkey="ModelValue_116"/>
    <SBMLMap SBMLid="H01__UGP_Vmax" COPASIkey="ModelValue_117"/>
    <SBMLMap SBMLid="H01__UGP_dm" COPASIkey="ModelValue_118"/>
    <SBMLMap SBMLid="H01__adp" COPASIkey="Metabolite_165"/>
    <SBMLMap SBMLid="H01__adp_tot" COPASIkey="ModelValue_47"/>
    <SBMLMap SBMLid="H01__atp" COPASIkey="Metabolite_163"/>
    <SBMLMap SBMLid="H01__gal" COPASIkey="Metabolite_145"/>
    <SBMLMap SBMLid="H01__gal1p" COPASIkey="Metabolite_155"/>
    <SBMLMap SBMLid="H01__galM" COPASIkey="Metabolite_147"/>
    <SBMLMap SBMLid="H01__galtol" COPASIkey="Metabolite_161"/>
    <SBMLMap SBMLid="H01__glc1p" COPASIkey="Metabolite_151"/>
    <SBMLMap SBMLid="H01__glc6p" COPASIkey="Metabolite_153"/>
    <SBMLMap SBMLid="H01__h2oM" COPASIkey="Metabolite_149"/>
    <SBMLMap SBMLid="H01__nadp" COPASIkey="Metabolite_175"/>
    <SBMLMap SBMLid="H01__nadp_tot" COPASIkey="ModelValue_46"/>
    <SBMLMap SBMLid="H01__nadph" COPASIkey="Metabolite_177"/>
    <SBMLMap SBMLid="H01__phos" COPASIkey="Metabolite_171"/>
    <SBMLMap SBMLid="H01__phos_tot" COPASIkey="ModelValue_49"/>
    <SBMLMap SBMLid="H01__ppi" COPASIkey="Metabolite_173"/>
    <SBMLMap SBMLid="H01__udp" COPASIkey="Metabolite_169"/>
    <SBMLMap SBMLid="H01__udp_tot" COPASIkey="ModelValue_48"/>
    <SBMLMap SBMLid="H01__udpgal" COPASIkey="Metabolite_159"/>
    <SBMLMap SBMLid="H01__udpglc" COPASIkey="Metabolite_157"/>
    <SBMLMap SBMLid="H01__utp" COPASIkey="Metabolite_167"/>
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
    <SBMLMap SBMLid="PP" COPASIkey="Compartment_1"/>
    <SBMLMap SBMLid="PPASE_f" COPASIkey="ModelValue_119"/>
    <SBMLMap SBMLid="PPASE_k_ppi" COPASIkey="ModelValue_120"/>
    <SBMLMap SBMLid="PPASE_n" COPASIkey="ModelValue_121"/>
    <SBMLMap SBMLid="PP__alb" COPASIkey="Metabolite_49"/>
    <SBMLMap SBMLid="PP__gal" COPASIkey="Metabolite_73"/>
    <SBMLMap SBMLid="PP__galM" COPASIkey="Metabolite_97"/>
    <SBMLMap SBMLid="PP__h2oM" COPASIkey="Metabolite_121"/>
    <SBMLMap SBMLid="PP__rbcM" COPASIkey="Metabolite_1"/>
    <SBMLMap SBMLid="PP__suc" COPASIkey="Metabolite_25"/>
    <SBMLMap SBMLid="PV" COPASIkey="Compartment_23"/>
    <SBMLMap SBMLid="PV__alb" COPASIkey="Metabolite_71"/>
    <SBMLMap SBMLid="PV__gal" COPASIkey="Metabolite_95"/>
    <SBMLMap SBMLid="PV__galM" COPASIkey="Metabolite_119"/>
    <SBMLMap SBMLid="PV__h2oM" COPASIkey="Metabolite_143"/>
    <SBMLMap SBMLid="PV__rbcM" COPASIkey="Metabolite_23"/>
    <SBMLMap SBMLid="PV__suc" COPASIkey="Metabolite_47"/>
    <SBMLMap SBMLid="REF_P" COPASIkey="ModelValue_44"/>
    <SBMLMap SBMLid="S001" COPASIkey="Compartment_3"/>
    <SBMLMap SBMLid="S001__alb" COPASIkey="Metabolite_51"/>
    <SBMLMap SBMLid="S001__gal" COPASIkey="Metabolite_75"/>
    <SBMLMap SBMLid="S001__galM" COPASIkey="Metabolite_99"/>
    <SBMLMap SBMLid="S001__h2oM" COPASIkey="Metabolite_123"/>
    <SBMLMap SBMLid="S001__rbcM" COPASIkey="Metabolite_3"/>
    <SBMLMap SBMLid="S001__suc" COPASIkey="Metabolite_27"/>
    <SBMLMap SBMLid="S002" COPASIkey="Compartment_7"/>
    <SBMLMap SBMLid="S002__alb" COPASIkey="Metabolite_55"/>
    <SBMLMap SBMLid="S002__gal" COPASIkey="Metabolite_79"/>
    <SBMLMap SBMLid="S002__galM" COPASIkey="Metabolite_103"/>
    <SBMLMap SBMLid="S002__h2oM" COPASIkey="Metabolite_127"/>
    <SBMLMap SBMLid="S002__rbcM" COPASIkey="Metabolite_7"/>
    <SBMLMap SBMLid="S002__suc" COPASIkey="Metabolite_31"/>
    <SBMLMap SBMLid="S003" COPASIkey="Compartment_11"/>
    <SBMLMap SBMLid="S003__alb" COPASIkey="Metabolite_59"/>
    <SBMLMap SBMLid="S003__gal" COPASIkey="Metabolite_83"/>
    <SBMLMap SBMLid="S003__galM" COPASIkey="Metabolite_107"/>
    <SBMLMap SBMLid="S003__h2oM" COPASIkey="Metabolite_131"/>
    <SBMLMap SBMLid="S003__rbcM" COPASIkey="Metabolite_11"/>
    <SBMLMap SBMLid="S003__suc" COPASIkey="Metabolite_35"/>
    <SBMLMap SBMLid="S004" COPASIkey="Compartment_15"/>
    <SBMLMap SBMLid="S004__alb" COPASIkey="Metabolite_63"/>
    <SBMLMap SBMLid="S004__gal" COPASIkey="Metabolite_87"/>
    <SBMLMap SBMLid="S004__galM" COPASIkey="Metabolite_111"/>
    <SBMLMap SBMLid="S004__h2oM" COPASIkey="Metabolite_135"/>
    <SBMLMap SBMLid="S004__rbcM" COPASIkey="Metabolite_15"/>
    <SBMLMap SBMLid="S004__suc" COPASIkey="Metabolite_39"/>
    <SBMLMap SBMLid="S005" COPASIkey="Compartment_19"/>
    <SBMLMap SBMLid="S005__alb" COPASIkey="Metabolite_67"/>
    <SBMLMap SBMLid="S005__gal" COPASIkey="Metabolite_91"/>
    <SBMLMap SBMLid="S005__galM" COPASIkey="Metabolite_115"/>
    <SBMLMap SBMLid="S005__h2oM" COPASIkey="Metabolite_139"/>
    <SBMLMap SBMLid="S005__rbcM" COPASIkey="Metabolite_19"/>
    <SBMLMap SBMLid="S005__suc" COPASIkey="Metabolite_43"/>
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
