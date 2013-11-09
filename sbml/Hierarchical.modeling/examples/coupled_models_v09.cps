<?xml version="1.0" encoding="UTF-8"?>
<!-- generated with COPASI 4.8 (Build 35) (http://www.copasi.org) at 2013-09-23 17:17:39 UTC -->
<?oxygen RNGSchema="http://www.copasi.org/static/schema/CopasiML.rng" type="xml"?>
<COPASI xmlns="http://www.copasi.org/static/schema" versionMajor="1" versionMinor="0" versionDevel="35">
  <ListOfFunctions>
    <Function key="Function_39" name="function_4_TPP" type="UserDefined" reversible="true">
      <Expression>
        D*(gal_pp-gal_1)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_246" name="D" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_258" name="gal_1" order="1" role="product"/>
        <ParameterDescription key="FunctionParameter_265" name="gal_pp" order="2" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_45" name="function_4_T1" type="UserDefined" reversible="true">
      <Expression>
        D*(gal_1-gal_2)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_269" name="D" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_270" name="gal_1" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_271" name="gal_2" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_46" name="function_4_T2" type="UserDefined" reversible="true">
      <Expression>
        D*(gal_2-gal_3)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_275" name="D" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_276" name="gal_2" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_277" name="gal_3" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_47" name="function_4_T3" type="UserDefined" reversible="true">
      <Expression>
        D*(gal_3-gal_4)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_281" name="D" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_282" name="gal_3" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_283" name="gal_4" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_48" name="function_4_T4" type="UserDefined" reversible="true">
      <Expression>
        D*(gal_4-gal_5)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_287" name="D" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_288" name="gal_4" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_289" name="gal_5" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_49" name="function_4_T5" type="UserDefined" reversible="true">
      <Expression>
        D*(gal_5-gal_pv)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_293" name="D" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_294" name="gal_5" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_295" name="gal_pv" order="2" role="product"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_50" name="function_4_TPV" type="UserDefined" reversible="false">
      <Expression>
        D*gal_pv/pv
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_299" name="D" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_300" name="gal_pv" order="1" role="substrate"/>
        <ParameterDescription key="FunctionParameter_301" name="pv" order="2" role="volume"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_51" name="function_4_Galactose Importer" type="UserDefined" reversible="true">
      <Expression>
        H1_GALI_vmax/H1_GALI_kgal*(gal_1-H1_gal)/(1+H1_gal/H1_GALI_kgal+gal_1/H1_GALI_kgal)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_306" name="H1_GALI_kgal" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_307" name="H1_GALI_vmax" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_308" name="H1_gal" order="2" role="product"/>
        <ParameterDescription key="FunctionParameter_309" name="gal_1" order="3" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_52" name="function_4_Galactose Clearance" type="UserDefined" reversible="false">
      <Expression>
        k1*H1_gal/(H1_gal+H1_GALK_kgal)/H1_cell
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_314" name="H1_GALK_kgal" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_315" name="H1_cell" order="1" role="volume"/>
        <ParameterDescription key="FunctionParameter_316" name="H1_gal" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_317" name="k1" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_53" name="function_4_Galactose Importer_2" type="UserDefined" reversible="true">
      <Expression>
        H2_GALI_vmax/H2_GALI_kgal*(gal_2-H2_gal)/(1+H2_gal/H2_GALI_kgal+gal_2/H2_GALI_kgal)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_322" name="H2_GALI_kgal" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_323" name="H2_GALI_vmax" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_324" name="H2_gal" order="2" role="product"/>
        <ParameterDescription key="FunctionParameter_325" name="gal_2" order="3" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_54" name="function_4_Galactose Clearance_2" type="UserDefined" reversible="false">
      <Expression>
        k2*H2_gal/(H2_gal+H2_GALK_kgal)/H2_cell
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_330" name="H2_GALK_kgal" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_331" name="H2_cell" order="1" role="volume"/>
        <ParameterDescription key="FunctionParameter_332" name="H2_gal" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_333" name="k2" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_55" name="function_4_Galactose Importer_3" type="UserDefined" reversible="true">
      <Expression>
        H3_GALI_vmax/H3_GALI_kgal*(gal_3-H3_gal)/(1+H3_gal/H3_GALI_kgal+gal_3/H3_GALI_kgal)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_338" name="H3_GALI_kgal" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_339" name="H3_GALI_vmax" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_340" name="H3_gal" order="2" role="product"/>
        <ParameterDescription key="FunctionParameter_341" name="gal_3" order="3" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_56" name="function_4_Galactose Clearance_3" type="UserDefined" reversible="false">
      <Expression>
        k3*H3_gal/(H3_gal+H3_GALK_kgal)/H3_cell
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_346" name="H3_GALK_kgal" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_347" name="H3_cell" order="1" role="volume"/>
        <ParameterDescription key="FunctionParameter_348" name="H3_gal" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_349" name="k3" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_57" name="function_4_Galactose Importer_4" type="UserDefined" reversible="true">
      <Expression>
        H4_GALI_vmax/H4_GALI_kgal*(gal_4-H4_gal)/(1+H4_gal/H4_GALI_kgal+gal_4/H4_GALI_kgal)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_354" name="H4_GALI_kgal" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_355" name="H4_GALI_vmax" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_356" name="H4_gal" order="2" role="product"/>
        <ParameterDescription key="FunctionParameter_357" name="gal_4" order="3" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_58" name="function_4_Galactose Clearance_4" type="UserDefined" reversible="false">
      <Expression>
        k4*H4_gal/(H4_gal+H4_GALK_kgal)/H4_cell
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_362" name="H4_GALK_kgal" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_363" name="H4_cell" order="1" role="volume"/>
        <ParameterDescription key="FunctionParameter_364" name="H4_gal" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_365" name="k4" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_59" name="function_4_Galactose Importer_5" type="UserDefined" reversible="true">
      <Expression>
        H5_GALI_vmax/H5_GALI_kgal*(gal_5-H5_gal)/(1+H5_gal/H5_GALI_kgal+gal_5/H5_GALI_kgal)
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_370" name="H5_GALI_kgal" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_371" name="H5_GALI_vmax" order="1" role="constant"/>
        <ParameterDescription key="FunctionParameter_372" name="H5_gal" order="2" role="product"/>
        <ParameterDescription key="FunctionParameter_373" name="gal_5" order="3" role="substrate"/>
      </ListOfParameterDescriptions>
    </Function>
    <Function key="Function_60" name="function_4_Galactose Clearance_5" type="UserDefined" reversible="false">
      <Expression>
        k5*H5_gal/(H5_gal+H5_GALK_kgal)/H5_cell
      </Expression>
      <ListOfParameterDescriptions>
        <ParameterDescription key="FunctionParameter_378" name="H5_GALK_kgal" order="0" role="constant"/>
        <ParameterDescription key="FunctionParameter_379" name="H5_cell" order="1" role="volume"/>
        <ParameterDescription key="FunctionParameter_380" name="H5_gal" order="2" role="substrate"/>
        <ParameterDescription key="FunctionParameter_381" name="k5" order="3" role="constant"/>
      </ListOfParameterDescriptions>
    </Function>
  </ListOfFunctions>
  <Model key="Model_0" name="full" simulationType="time" timeUnit="s" volumeUnit="l" areaUnit="m²" lengthUnit="m" quantityUnit="mmol" type="deterministic" avogadroConstant="6.02214179e+023">
    <MiriamAnnotation>
<rdf:RDF
   xmlns:dcterms="http://purl.org/dc/terms/"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="#Model_0">
    <dcterms:created>
      <rdf:Description>
        <dcterms:W3CDTF>2013-09-23T19:05:28Z</dcterms:W3CDTF>
      </rdf:Description>
    </dcterms:created>
  </rdf:Description>
</rdf:RDF>

    </MiriamAnnotation>
    <ListOfCompartments>
      <Compartment key="Compartment_0" name="periportal" simulationType="fixed" dimensionality="3">
        <InitialExpression>
          &lt;CN=Root,Model=full,Vector=Values[Vblood],Reference=InitialValue&gt;
        </InitialExpression>
      </Compartment>
      <Compartment key="Compartment_1" name="blood1" simulationType="fixed" dimensionality="3">
        <InitialExpression>
          &lt;CN=Root,Model=full,Vector=Values[Vblood],Reference=InitialValue&gt;
        </InitialExpression>
      </Compartment>
      <Compartment key="Compartment_2" name="blood2" simulationType="fixed" dimensionality="3">
        <InitialExpression>
          &lt;CN=Root,Model=full,Vector=Values[Vblood],Reference=InitialValue&gt;
        </InitialExpression>
      </Compartment>
      <Compartment key="Compartment_3" name="blood3" simulationType="fixed" dimensionality="3">
        <InitialExpression>
          &lt;CN=Root,Model=full,Vector=Values[Vblood],Reference=InitialValue&gt;
        </InitialExpression>
      </Compartment>
      <Compartment key="Compartment_4" name="blood4" simulationType="fixed" dimensionality="3">
        <InitialExpression>
          &lt;CN=Root,Model=full,Vector=Values[Vblood],Reference=InitialValue&gt;
        </InitialExpression>
      </Compartment>
      <Compartment key="Compartment_5" name="blood5" simulationType="fixed" dimensionality="3">
        <InitialExpression>
          &lt;CN=Root,Model=full,Vector=Values[Vblood],Reference=InitialValue&gt;
        </InitialExpression>
      </Compartment>
      <Compartment key="Compartment_6" name="perivenous" simulationType="fixed" dimensionality="3">
        <InitialExpression>
          &lt;CN=Root,Model=full,Vector=Values[Vblood],Reference=InitialValue&gt;
        </InitialExpression>
      </Compartment>
      <Compartment key="Compartment_7" name="Hepatocyte" simulationType="fixed" dimensionality="3">
        <InitialExpression>
          2*&lt;CN=Root,Model=full,Vector=Values[Vblood],Reference=InitialValue&gt;
        </InitialExpression>
      </Compartment>
      <Compartment key="Compartment_8" name="Hepatocyte_2" simulationType="fixed" dimensionality="3">
        <InitialExpression>
          2*&lt;CN=Root,Model=full,Vector=Values[Vblood],Reference=InitialValue&gt;
        </InitialExpression>
      </Compartment>
      <Compartment key="Compartment_9" name="Hepatocyte_3" simulationType="fixed" dimensionality="3">
        <InitialExpression>
          2*&lt;CN=Root,Model=full,Vector=Values[Vblood],Reference=InitialValue&gt;
        </InitialExpression>
      </Compartment>
      <Compartment key="Compartment_10" name="Hepatocyte_4" simulationType="fixed" dimensionality="3">
        <InitialExpression>
          2*&lt;CN=Root,Model=full,Vector=Values[Vblood],Reference=InitialValue&gt;
        </InitialExpression>
      </Compartment>
      <Compartment key="Compartment_11" name="Hepatocyte_5" simulationType="fixed" dimensionality="3">
        <InitialExpression>
          2*&lt;CN=Root,Model=full,Vector=Values[Vblood],Reference=InitialValue&gt;
        </InitialExpression>
      </Compartment>
    </ListOfCompartments>
    <ListOfMetabolites>
      <Metabolite key="Metabolite_0" name="D-galactose" simulationType="fixed" compartment="Compartment_0">
      </Metabolite>
      <Metabolite key="Metabolite_1" name="D-galactose" simulationType="reactions" compartment="Compartment_1">
      </Metabolite>
      <Metabolite key="Metabolite_2" name="D-galactose" simulationType="reactions" compartment="Compartment_2">
      </Metabolite>
      <Metabolite key="Metabolite_3" name="D-galactose" simulationType="reactions" compartment="Compartment_3">
      </Metabolite>
      <Metabolite key="Metabolite_4" name="D-galactose" simulationType="reactions" compartment="Compartment_4">
      </Metabolite>
      <Metabolite key="Metabolite_5" name="D-galactose" simulationType="reactions" compartment="Compartment_5">
      </Metabolite>
      <Metabolite key="Metabolite_6" name="D-galactose" simulationType="reactions" compartment="Compartment_6">
      </Metabolite>
      <Metabolite key="Metabolite_7" name="D-galactose" simulationType="reactions" compartment="Compartment_7">
      </Metabolite>
      <Metabolite key="Metabolite_8" name="D-galactose" simulationType="reactions" compartment="Compartment_8">
      </Metabolite>
      <Metabolite key="Metabolite_9" name="D-galactose" simulationType="reactions" compartment="Compartment_9">
      </Metabolite>
      <Metabolite key="Metabolite_10" name="D-galactose" simulationType="reactions" compartment="Compartment_10">
      </Metabolite>
      <Metabolite key="Metabolite_11" name="D-galactose" simulationType="reactions" compartment="Compartment_11">
      </Metabolite>
    </ListOfMetabolites>
    <ListOfModelValues>
      <ModelValue key="ModelValue_0" name="Vblood" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_1" name="D" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_2" name="k1" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_3" name="k2" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_4" name="k3" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_5" name="k4" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_6" name="k5" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_7" name="H1_GALI_vmax" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_8" name="H1_GALI_kgal" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_9" name="H1_GALK_kgal" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_10" name="H2_GALI_vmax" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_11" name="H2_GALI_kgal" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_12" name="H2_GALK_kgal" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_13" name="H3_GALI_vmax" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_14" name="H3_GALI_kgal" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_15" name="H3_GALK_kgal" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_16" name="H4_GALI_vmax" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_17" name="H4_GALI_kgal" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_18" name="H4_GALK_kgal" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_19" name="H5_GALI_vmax" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_20" name="H5_GALI_kgal" simulationType="fixed">
      </ModelValue>
      <ModelValue key="ModelValue_21" name="H5_GALK_kgal" simulationType="fixed">
      </ModelValue>
    </ListOfModelValues>
    <ListOfReactions>
      <Reaction key="Reaction_0" name="TPP" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_0" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_1" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_1630" name="D" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_39">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_246">
              <SourceParameter reference="ModelValue_1"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_258">
              <SourceParameter reference="Metabolite_1"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_265">
              <SourceParameter reference="Metabolite_0"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_1" name="T1" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_1" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_2" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_1631" name="D" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_45">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_269">
              <SourceParameter reference="ModelValue_1"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_270">
              <SourceParameter reference="Metabolite_1"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_271">
              <SourceParameter reference="Metabolite_2"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_2" name="T2" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_2" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_3" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_1632" name="D" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_46">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_275">
              <SourceParameter reference="ModelValue_1"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_276">
              <SourceParameter reference="Metabolite_2"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_277">
              <SourceParameter reference="Metabolite_3"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_3" name="T3" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_3" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_4" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_1635" name="D" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_47">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_281">
              <SourceParameter reference="ModelValue_1"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_282">
              <SourceParameter reference="Metabolite_3"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_283">
              <SourceParameter reference="Metabolite_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_4" name="T4" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_4" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_5" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_1634" name="D" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_48">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_287">
              <SourceParameter reference="ModelValue_1"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_288">
              <SourceParameter reference="Metabolite_4"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_289">
              <SourceParameter reference="Metabolite_5"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_5" name="T5" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_5" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_6" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_1636" name="D" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_49">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_293">
              <SourceParameter reference="ModelValue_1"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_294">
              <SourceParameter reference="Metabolite_5"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_295">
              <SourceParameter reference="Metabolite_6"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_6" name="TPV" reversible="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_6" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_1633" name="D" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_50">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_299">
              <SourceParameter reference="ModelValue_1"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_300">
              <SourceParameter reference="Metabolite_6"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_301">
              <SourceParameter reference="Compartment_6"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_7" name="Galactose Importer" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_1" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_7" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_1637" name="H1_GALI_kgal" value="1"/>
          <Constant key="Parameter_1638" name="H1_GALI_vmax" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_51">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_306">
              <SourceParameter reference="ModelValue_8"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_307">
              <SourceParameter reference="ModelValue_7"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_308">
              <SourceParameter reference="Metabolite_7"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_309">
              <SourceParameter reference="Metabolite_1"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_8" name="Galactose Clearance" reversible="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_7" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_1639" name="H1_GALK_kgal" value="1"/>
          <Constant key="Parameter_1640" name="k1" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_52">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_314">
              <SourceParameter reference="ModelValue_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_315">
              <SourceParameter reference="Compartment_7"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_316">
              <SourceParameter reference="Metabolite_7"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_317">
              <SourceParameter reference="ModelValue_2"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_9" name="Galactose Importer_2" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_2" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_8" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_1641" name="H2_GALI_kgal" value="1"/>
          <Constant key="Parameter_1642" name="H2_GALI_vmax" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_53">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_322">
              <SourceParameter reference="ModelValue_11"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_323">
              <SourceParameter reference="ModelValue_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_324">
              <SourceParameter reference="Metabolite_8"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_325">
              <SourceParameter reference="Metabolite_2"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_10" name="Galactose Clearance_2" reversible="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_8" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_1643" name="H2_GALK_kgal" value="1"/>
          <Constant key="Parameter_1644" name="k2" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_54">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_330">
              <SourceParameter reference="ModelValue_12"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_331">
              <SourceParameter reference="Compartment_8"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_332">
              <SourceParameter reference="Metabolite_8"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_333">
              <SourceParameter reference="ModelValue_3"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_11" name="Galactose Importer_3" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_3" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_9" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_1645" name="H3_GALI_kgal" value="1"/>
          <Constant key="Parameter_1646" name="H3_GALI_vmax" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_55">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_338">
              <SourceParameter reference="ModelValue_14"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_339">
              <SourceParameter reference="ModelValue_13"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_340">
              <SourceParameter reference="Metabolite_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_341">
              <SourceParameter reference="Metabolite_3"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_12" name="Galactose Clearance_3" reversible="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_9" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_1647" name="H3_GALK_kgal" value="1"/>
          <Constant key="Parameter_1648" name="k3" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_56">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_346">
              <SourceParameter reference="ModelValue_15"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_347">
              <SourceParameter reference="Compartment_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_348">
              <SourceParameter reference="Metabolite_9"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_349">
              <SourceParameter reference="ModelValue_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_13" name="Galactose Importer_4" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_4" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_10" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_1649" name="H4_GALI_kgal" value="1"/>
          <Constant key="Parameter_1650" name="H4_GALI_vmax" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_57">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_354">
              <SourceParameter reference="ModelValue_17"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_355">
              <SourceParameter reference="ModelValue_16"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_356">
              <SourceParameter reference="Metabolite_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_357">
              <SourceParameter reference="Metabolite_4"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_14" name="Galactose Clearance_4" reversible="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_10" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_1651" name="H4_GALK_kgal" value="1"/>
          <Constant key="Parameter_1652" name="k4" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_58">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_362">
              <SourceParameter reference="ModelValue_18"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_363">
              <SourceParameter reference="Compartment_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_364">
              <SourceParameter reference="Metabolite_10"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_365">
              <SourceParameter reference="ModelValue_5"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_15" name="Galactose Importer_5" reversible="true">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_5" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfProducts>
          <Product metabolite="Metabolite_11" stoichiometry="1"/>
        </ListOfProducts>
        <ListOfConstants>
          <Constant key="Parameter_1655" name="H5_GALI_kgal" value="1"/>
          <Constant key="Parameter_1654" name="H5_GALI_vmax" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_59">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_370">
              <SourceParameter reference="ModelValue_20"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_371">
              <SourceParameter reference="ModelValue_19"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_372">
              <SourceParameter reference="Metabolite_11"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_373">
              <SourceParameter reference="Metabolite_5"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
      <Reaction key="Reaction_16" name="Galactose Clearance_5" reversible="false">
        <ListOfSubstrates>
          <Substrate metabolite="Metabolite_11" stoichiometry="1"/>
        </ListOfSubstrates>
        <ListOfConstants>
          <Constant key="Parameter_1653" name="H5_GALK_kgal" value="1"/>
          <Constant key="Parameter_1656" name="k5" value="1"/>
        </ListOfConstants>
        <KineticLaw function="Function_60">
          <ListOfCallParameters>
            <CallParameter functionParameter="FunctionParameter_378">
              <SourceParameter reference="ModelValue_21"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_379">
              <SourceParameter reference="Compartment_11"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_380">
              <SourceParameter reference="Metabolite_11"/>
            </CallParameter>
            <CallParameter functionParameter="FunctionParameter_381">
              <SourceParameter reference="ModelValue_6"/>
            </CallParameter>
          </ListOfCallParameters>
        </KineticLaw>
      </Reaction>
    </ListOfReactions>
    <StateTemplate>
      <StateTemplateVariable objectReference="Model_0"/>
      <StateTemplateVariable objectReference="Metabolite_1"/>
      <StateTemplateVariable objectReference="Metabolite_3"/>
      <StateTemplateVariable objectReference="Metabolite_5"/>
      <StateTemplateVariable objectReference="Metabolite_4"/>
      <StateTemplateVariable objectReference="Metabolite_2"/>
      <StateTemplateVariable objectReference="Metabolite_6"/>
      <StateTemplateVariable objectReference="Metabolite_7"/>
      <StateTemplateVariable objectReference="Metabolite_9"/>
      <StateTemplateVariable objectReference="Metabolite_8"/>
      <StateTemplateVariable objectReference="Metabolite_10"/>
      <StateTemplateVariable objectReference="Metabolite_11"/>
      <StateTemplateVariable objectReference="Metabolite_0"/>
      <StateTemplateVariable objectReference="ModelValue_0"/>
      <StateTemplateVariable objectReference="ModelValue_1"/>
      <StateTemplateVariable objectReference="ModelValue_2"/>
      <StateTemplateVariable objectReference="ModelValue_3"/>
      <StateTemplateVariable objectReference="ModelValue_4"/>
      <StateTemplateVariable objectReference="ModelValue_5"/>
      <StateTemplateVariable objectReference="ModelValue_6"/>
      <StateTemplateVariable objectReference="ModelValue_7"/>
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
      <StateTemplateVariable objectReference="ModelValue_18"/>
      <StateTemplateVariable objectReference="ModelValue_19"/>
      <StateTemplateVariable objectReference="ModelValue_20"/>
      <StateTemplateVariable objectReference="ModelValue_21"/>
      <StateTemplateVariable objectReference="Compartment_0"/>
      <StateTemplateVariable objectReference="Compartment_1"/>
      <StateTemplateVariable objectReference="Compartment_2"/>
      <StateTemplateVariable objectReference="Compartment_3"/>
      <StateTemplateVariable objectReference="Compartment_4"/>
      <StateTemplateVariable objectReference="Compartment_5"/>
      <StateTemplateVariable objectReference="Compartment_6"/>
      <StateTemplateVariable objectReference="Compartment_7"/>
      <StateTemplateVariable objectReference="Compartment_8"/>
      <StateTemplateVariable objectReference="Compartment_9"/>
      <StateTemplateVariable objectReference="Compartment_10"/>
      <StateTemplateVariable objectReference="Compartment_11"/>
    </StateTemplate>
    <InitialState type="initialState">
      0 0 0 0 0 0 0 0 0 0 0 0 1806642537000.002 1e-009 5e-009 1e-010 2e-010 4e-010 8e-010 1.6e-009 1e-007 1 0.3 1e-007 1 0.3 1e-007 1 0.3 1e-007 1 0.3 1e-007 1 0.3 1e-009 1e-009 1e-009 1e-009 1e-009 1e-009 1e-009 2e-009 2e-009 2e-009 2e-009 2e-009 
    </InitialState>
  </Model>
  <ListOfTasks>
    <Task key="Task_10" name="Steady-State" type="steadyState" scheduled="false" updateModel="false">
      <Report reference="Report_7" target="" append="1"/>
      <Problem>
        <Parameter name="JacobianRequested" type="bool" value="1"/>
        <Parameter name="StabilityAnalysisRequested" type="bool" value="1"/>
      </Problem>
      <Method name="Enhanced Newton" type="EnhancedNewton">
        <Parameter name="Resolution" type="unsignedFloat" value="1e-009"/>
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
    <Task key="Task_9" name="Time-Course" type="timeCourse" scheduled="false" updateModel="false">
      <Problem>
        <Parameter name="StepNumber" type="unsignedInteger" value="100"/>
        <Parameter name="StepSize" type="float" value="1"/>
        <Parameter name="Duration" type="float" value="100"/>
        <Parameter name="TimeSeriesRequested" type="bool" value="1"/>
        <Parameter name="OutputStartTime" type="float" value="0"/>
        <Parameter name="Output Event" type="bool" value="0"/>
      </Problem>
      <Method name="Deterministic (LSODA)" type="Deterministic(LSODA)">
        <Parameter name="Integrate Reduced Model" type="bool" value="0"/>
        <Parameter name="Relative Tolerance" type="unsignedFloat" value="1e-006"/>
        <Parameter name="Absolute Tolerance" type="unsignedFloat" value="1e-012"/>
        <Parameter name="Max Internal Steps" type="unsignedInteger" value="10000"/>
      </Method>
    </Task>
    <Task key="Task_8" name="Scan" type="scan" scheduled="false" updateModel="false">
      <Problem>
        <Parameter name="Subtask" type="unsignedInteger" value="0"/>
        <ParameterGroup name="ScanItems">
          <ParameterGroup name="ScanItem">
            <Parameter name="Number of steps" type="unsignedInteger" value="100"/>
            <Parameter name="Type" type="unsignedInteger" value="1"/>
            <Parameter name="Object" type="cn" value="CN=Root,Model=full,Vector=Compartments[periportal],Vector=Metabolites[D-galactose],Reference=InitialConcentration"/>
            <Parameter name="Minimum" type="float" value="0"/>
            <Parameter name="Maximum" type="float" value="10"/>
            <Parameter name="log" type="bool" value="0"/>
          </ParameterGroup>
        </ParameterGroup>
        <Parameter name="Output in subtask" type="bool" value="0"/>
        <Parameter name="Adjust initial conditions" type="bool" value="0"/>
      </Problem>
      <Method name="Scan Framework" type="ScanFramework">
      </Method>
    </Task>
    <Task key="Task_7" name="Elementary Flux Modes" type="fluxMode" scheduled="false" updateModel="false">
      <Report reference="Report_6" target="" append="1"/>
      <Problem>
      </Problem>
      <Method name="EFM Algorithm" type="EFMAlgorithm">
      </Method>
    </Task>
    <Task key="Task_6" name="Optimization" type="optimization" scheduled="false" updateModel="false">
      <Report reference="Report_5" target="" append="1"/>
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
    <Task key="Task_5" name="Parameter Estimation" type="parameterFitting" scheduled="false" updateModel="false">
      <Report reference="Report_4" target="" append="1"/>
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
      </Problem>
      <Method name="Evolutionary Programming" type="EvolutionaryProgram">
        <Parameter name="Number of Generations" type="unsignedInteger" value="200"/>
        <Parameter name="Population Size" type="unsignedInteger" value="20"/>
        <Parameter name="Random Number Generator" type="unsignedInteger" value="1"/>
        <Parameter name="Seed" type="unsignedInteger" value="0"/>
      </Method>
    </Task>
    <Task key="Task_4" name="Metabolic Control Analysis" type="metabolicControlAnalysis" scheduled="false" updateModel="false">
      <Report reference="Report_3" target="" append="1"/>
      <Problem>
        <Parameter name="Steady-State" type="key" value="Task_10"/>
      </Problem>
      <Method name="MCA Method (Reder)" type="MCAMethod(Reder)">
        <Parameter name="Modulation Factor" type="unsignedFloat" value="1e-009"/>
      </Method>
    </Task>
    <Task key="Task_3" name="Lyapunov Exponents" type="lyapunovExponents" scheduled="false" updateModel="false">
      <Report reference="Report_2" target="" append="1"/>
      <Problem>
        <Parameter name="ExponentNumber" type="unsignedInteger" value="3"/>
        <Parameter name="DivergenceRequested" type="bool" value="1"/>
        <Parameter name="TransientTime" type="float" value="0"/>
      </Problem>
      <Method name="Wolf Method" type="WolfMethod">
        <Parameter name="Orthonormalization Interval" type="unsignedFloat" value="1"/>
        <Parameter name="Overall time" type="unsignedFloat" value="1000"/>
        <Parameter name="Relative Tolerance" type="unsignedFloat" value="1e-006"/>
        <Parameter name="Absolute Tolerance" type="unsignedFloat" value="1e-012"/>
        <Parameter name="Max Internal Steps" type="unsignedInteger" value="10000"/>
      </Method>
    </Task>
    <Task key="Task_2" name="Time Scale Separation Analysis" type="timeScaleSeparationAnalysis" scheduled="false" updateModel="false">
      <Report reference="Report_1" target="" append="1"/>
      <Problem>
        <Parameter name="StepNumber" type="unsignedInteger" value="100"/>
        <Parameter name="StepSize" type="float" value="0.01"/>
        <Parameter name="Duration" type="float" value="1"/>
        <Parameter name="TimeSeriesRequested" type="bool" value="1"/>
        <Parameter name="OutputStartTime" type="float" value="0"/>
      </Problem>
      <Method name="ILDM (LSODA,Deuflhard)" type="TimeScaleSeparation(ILDM,Deuflhard)">
        <Parameter name="Deuflhard Tolerance" type="unsignedFloat" value="1e-006"/>
      </Method>
    </Task>
    <Task key="Task_1" name="Sensitivities" type="sensitivities" scheduled="false" updateModel="false">
      <Report reference="Report_0" target="" append="1"/>
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
        <Parameter name="Delta minimum" type="unsignedFloat" value="1e-012"/>
      </Method>
    </Task>
    <Task key="Task_11" name="Moieties" type="moieties" scheduled="false" updateModel="false">
      <Problem>
      </Problem>
      <Method name="Householder Reduction" type="Householder">
      </Method>
    </Task>
  </ListOfTasks>
  <ListOfReports>
    <Report key="Report_7" name="Steady-State" taskType="steadyState" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Footer>
        <Object cn="CN=Root,Vector=TaskList[Steady-State]"/>
      </Footer>
    </Report>
    <Report key="Report_6" name="Elementary Flux Modes" taskType="fluxMode" separator="&#x09;" precision="6">
      <Comment>
        Automatically generated report.
      </Comment>
      <Footer>
        <Object cn="CN=Root,Vector=TaskList[Elementary Flux Modes],Object=Result"/>
      </Footer>
    </Report>
    <Report key="Report_5" name="Optimization" taskType="optimization" separator="&#x09;" precision="6">
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
    <Report key="Report_4" name="Parameter Estimation" taskType="parameterFitting" separator="&#x09;" precision="6">
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
    <Report key="Report_3" name="Metabolic Control Analysis" taskType="metabolicControlAnalysis" separator="&#x09;" precision="6">
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
    <Report key="Report_2" name="Lyapunov Exponents" taskType="lyapunovExponents" separator="&#x09;" precision="6">
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
    <Report key="Report_1" name="Time Scale Separation Analysis" taskType="timeScaleSeparationAnalysis" separator="&#x09;" precision="6">
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
    <Report key="Report_0" name="Sensitivities" taskType="sensitivities" separator="&#x09;" precision="6">
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
  </ListOfReports>
  <ListOfPlots>
    <PlotSpecification name="Blood Galactose" type="Plot2D" active="1">
      <Parameter name="log X" type="bool" value="0"/>
      <Parameter name="log Y" type="bool" value="0"/>
      <ListOfPlotItems>
        <PlotItem name="[D-galactose{blood1}]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=full,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=full,Vector=Compartments[blood1],Vector=Metabolites[D-galactose],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[D-galactose{blood2}]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=full,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=full,Vector=Compartments[blood2],Vector=Metabolites[D-galactose],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[D-galactose{blood3}]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=full,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=full,Vector=Compartments[blood3],Vector=Metabolites[D-galactose],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[D-galactose{blood4}]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=full,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=full,Vector=Compartments[blood4],Vector=Metabolites[D-galactose],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[D-galactose{blood5}]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=full,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=full,Vector=Compartments[blood5],Vector=Metabolites[D-galactose],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[D-galactose{periportal}]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=full,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=full,Vector=Compartments[periportal],Vector=Metabolites[D-galactose],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[D-galactose{perivenous}]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=full,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=full,Vector=Compartments[perivenous],Vector=Metabolites[D-galactose],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
      </ListOfPlotItems>
    </PlotSpecification>
    <PlotSpecification name="Hepatocyte Galactose" type="Plot2D" active="1">
      <Parameter name="log X" type="bool" value="0"/>
      <Parameter name="log Y" type="bool" value="0"/>
      <ListOfPlotItems>
        <PlotItem name="[D-galactose{Hepatocyte_2}]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=full,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=full,Vector=Compartments[Hepatocyte_2],Vector=Metabolites[D-galactose],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[D-galactose{Hepatocyte_3}]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=full,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=full,Vector=Compartments[Hepatocyte_3],Vector=Metabolites[D-galactose],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[D-galactose{Hepatocyte_4}]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=full,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=full,Vector=Compartments[Hepatocyte_4],Vector=Metabolites[D-galactose],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[D-galactose{Hepatocyte_5}]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=full,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=full,Vector=Compartments[Hepatocyte_5],Vector=Metabolites[D-galactose],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="[D-galactose{Hepatocyte}]|Time" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=full,Reference=Time"/>
            <ChannelSpec cn="CN=Root,Model=full,Vector=Compartments[Hepatocyte],Vector=Metabolites[D-galactose],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
      </ListOfPlotItems>
    </PlotSpecification>
    <PlotSpecification name="Parameter Scan PP Galactose" type="Plot2D" active="1">
      <Parameter name="log X" type="bool" value="0"/>
      <Parameter name="log Y" type="bool" value="0"/>
      <ListOfPlotItems>
        <PlotItem name="(Galactose Clearance).Flux|[D-galactose{periportal}]_0" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=full,Vector=Compartments[periportal],Vector=Metabolites[D-galactose],Reference=InitialConcentration"/>
            <ChannelSpec cn="CN=Root,Model=full,Vector=Reactions[Galactose Clearance],Reference=Flux"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="(Galactose Clearance_2).Flux|[D-galactose{periportal}]_0" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=full,Vector=Compartments[periportal],Vector=Metabolites[D-galactose],Reference=InitialConcentration"/>
            <ChannelSpec cn="CN=Root,Model=full,Vector=Reactions[Galactose Clearance_2],Reference=Flux"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="(Galactose Clearance_3).Flux|[D-galactose{periportal}]_0" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=full,Vector=Compartments[periportal],Vector=Metabolites[D-galactose],Reference=InitialConcentration"/>
            <ChannelSpec cn="CN=Root,Model=full,Vector=Reactions[Galactose Clearance_3],Reference=Flux"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="(Galactose Clearance_4).Flux|[D-galactose{periportal}]_0" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=full,Vector=Compartments[periportal],Vector=Metabolites[D-galactose],Reference=InitialConcentration"/>
            <ChannelSpec cn="CN=Root,Model=full,Vector=Reactions[Galactose Clearance_4],Reference=Flux"/>
          </ListOfChannels>
        </PlotItem>
        <PlotItem name="(Galactose Clearance_5).Flux|[D-galactose{periportal}]_0" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=full,Vector=Compartments[periportal],Vector=Metabolites[D-galactose],Reference=InitialConcentration"/>
            <ChannelSpec cn="CN=Root,Model=full,Vector=Reactions[Galactose Clearance_5],Reference=Flux"/>
          </ListOfChannels>
        </PlotItem>
      </ListOfPlotItems>
    </PlotSpecification>
    <PlotSpecification name="Periportal vs. perivenious" type="Plot2D" active="1">
      <Parameter name="log X" type="bool" value="0"/>
      <Parameter name="log Y" type="bool" value="0"/>
      <ListOfPlotItems>
        <PlotItem name="[D-galactose{perivenous}]|[D-galactose{periportal}]" type="Curve2D">
          <Parameter name="Line type" type="unsignedInteger" value="0"/>
          <Parameter name="Recording Activity" type="string" value="during"/>
          <ListOfChannels>
            <ChannelSpec cn="CN=Root,Model=full,Vector=Compartments[periportal],Vector=Metabolites[D-galactose],Reference=Concentration"/>
            <ChannelSpec cn="CN=Root,Model=full,Vector=Compartments[perivenous],Vector=Metabolites[D-galactose],Reference=Concentration"/>
          </ListOfChannels>
        </PlotItem>
      </ListOfPlotItems>
    </PlotSpecification>
  </ListOfPlots>
  <GUI>
  </GUI>
  <SBMLReference file="full_flatten_v09.xml">
    <SBMLMap SBMLid="D" COPASIkey="ModelValue_1"/>
    <SBMLMap SBMLid="H1_GALI" COPASIkey="Reaction_7"/>
    <SBMLMap SBMLid="H1_GALI_kgal" COPASIkey="ModelValue_8"/>
    <SBMLMap SBMLid="H1_GALI_vmax" COPASIkey="ModelValue_7"/>
    <SBMLMap SBMLid="H1_GALK" COPASIkey="Reaction_8"/>
    <SBMLMap SBMLid="H1_GALK_kgal" COPASIkey="ModelValue_9"/>
    <SBMLMap SBMLid="H1_cell" COPASIkey="Compartment_7"/>
    <SBMLMap SBMLid="H1_gal" COPASIkey="Metabolite_7"/>
    <SBMLMap SBMLid="H2_GALI" COPASIkey="Reaction_9"/>
    <SBMLMap SBMLid="H2_GALI_kgal" COPASIkey="ModelValue_11"/>
    <SBMLMap SBMLid="H2_GALI_vmax" COPASIkey="ModelValue_10"/>
    <SBMLMap SBMLid="H2_GALK" COPASIkey="Reaction_10"/>
    <SBMLMap SBMLid="H2_GALK_kgal" COPASIkey="ModelValue_12"/>
    <SBMLMap SBMLid="H2_cell" COPASIkey="Compartment_8"/>
    <SBMLMap SBMLid="H2_gal" COPASIkey="Metabolite_8"/>
    <SBMLMap SBMLid="H3_GALI" COPASIkey="Reaction_11"/>
    <SBMLMap SBMLid="H3_GALI_kgal" COPASIkey="ModelValue_14"/>
    <SBMLMap SBMLid="H3_GALI_vmax" COPASIkey="ModelValue_13"/>
    <SBMLMap SBMLid="H3_GALK" COPASIkey="Reaction_12"/>
    <SBMLMap SBMLid="H3_GALK_kgal" COPASIkey="ModelValue_15"/>
    <SBMLMap SBMLid="H3_cell" COPASIkey="Compartment_9"/>
    <SBMLMap SBMLid="H3_gal" COPASIkey="Metabolite_9"/>
    <SBMLMap SBMLid="H4_GALI" COPASIkey="Reaction_13"/>
    <SBMLMap SBMLid="H4_GALI_kgal" COPASIkey="ModelValue_17"/>
    <SBMLMap SBMLid="H4_GALI_vmax" COPASIkey="ModelValue_16"/>
    <SBMLMap SBMLid="H4_GALK" COPASIkey="Reaction_14"/>
    <SBMLMap SBMLid="H4_GALK_kgal" COPASIkey="ModelValue_18"/>
    <SBMLMap SBMLid="H4_cell" COPASIkey="Compartment_10"/>
    <SBMLMap SBMLid="H4_gal" COPASIkey="Metabolite_10"/>
    <SBMLMap SBMLid="H5_GALI" COPASIkey="Reaction_15"/>
    <SBMLMap SBMLid="H5_GALI_kgal" COPASIkey="ModelValue_20"/>
    <SBMLMap SBMLid="H5_GALI_vmax" COPASIkey="ModelValue_19"/>
    <SBMLMap SBMLid="H5_GALK" COPASIkey="Reaction_16"/>
    <SBMLMap SBMLid="H5_GALK_kgal" COPASIkey="ModelValue_21"/>
    <SBMLMap SBMLid="H5_cell" COPASIkey="Compartment_11"/>
    <SBMLMap SBMLid="H5_gal" COPASIkey="Metabolite_11"/>
    <SBMLMap SBMLid="T1" COPASIkey="Reaction_1"/>
    <SBMLMap SBMLid="T2" COPASIkey="Reaction_2"/>
    <SBMLMap SBMLid="T3" COPASIkey="Reaction_3"/>
    <SBMLMap SBMLid="T4" COPASIkey="Reaction_4"/>
    <SBMLMap SBMLid="T5" COPASIkey="Reaction_5"/>
    <SBMLMap SBMLid="TPP" COPASIkey="Reaction_0"/>
    <SBMLMap SBMLid="TPV" COPASIkey="Reaction_6"/>
    <SBMLMap SBMLid="Vblood" COPASIkey="ModelValue_0"/>
    <SBMLMap SBMLid="blood1" COPASIkey="Compartment_1"/>
    <SBMLMap SBMLid="blood2" COPASIkey="Compartment_2"/>
    <SBMLMap SBMLid="blood3" COPASIkey="Compartment_3"/>
    <SBMLMap SBMLid="blood4" COPASIkey="Compartment_4"/>
    <SBMLMap SBMLid="blood5" COPASIkey="Compartment_5"/>
    <SBMLMap SBMLid="gal_1" COPASIkey="Metabolite_1"/>
    <SBMLMap SBMLid="gal_2" COPASIkey="Metabolite_2"/>
    <SBMLMap SBMLid="gal_3" COPASIkey="Metabolite_3"/>
    <SBMLMap SBMLid="gal_4" COPASIkey="Metabolite_4"/>
    <SBMLMap SBMLid="gal_5" COPASIkey="Metabolite_5"/>
    <SBMLMap SBMLid="gal_pp" COPASIkey="Metabolite_0"/>
    <SBMLMap SBMLid="gal_pv" COPASIkey="Metabolite_6"/>
    <SBMLMap SBMLid="k1" COPASIkey="ModelValue_2"/>
    <SBMLMap SBMLid="k2" COPASIkey="ModelValue_3"/>
    <SBMLMap SBMLid="k3" COPASIkey="ModelValue_4"/>
    <SBMLMap SBMLid="k4" COPASIkey="ModelValue_5"/>
    <SBMLMap SBMLid="k5" COPASIkey="ModelValue_6"/>
    <SBMLMap SBMLid="pp" COPASIkey="Compartment_0"/>
    <SBMLMap SBMLid="pv" COPASIkey="Compartment_6"/>
  </SBMLReference>
</COPASI>
