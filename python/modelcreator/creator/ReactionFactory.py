'''
Created on Jun 19, 2014

@author: mkoenig
'''
import libsbml
from creator.Naming import *

def createKineticLaw(model, reaction, formula):
    law = reaction.createKineticLaw();
    astnode = libsbml.parseL3FormulaWithModel(formula, model)
    law.setMath(astnode);
    return law;

def createFlowReaction(model, sid, c_from, c_to):
    sid_from = createLocalizedId(c_from, sid)
    sid_to = createLocalizedId(c_to, sid)
    rid = createFlowId(c_from, c_to, sid)
    rname = createFlowName(c_from, c_to, sid)
    
    r = model.createReaction()
    r.setId(rid)
    r.setName(rname)
    r.setReversible(False)
    r.setFast(False);
    
    sref = r.createReactant();
    sref.setSpecies(sid_from)
    sref.setStoichiometry(1.0);
    sref.setConstant(True);
    if not sid_to == "NULL":
        sref = r.createProduct();
        sref.setSpecies(sid_to)
        sref.setStoichiometry(1.0);
        sref.setConstant(True);
         
    formula = 'flow_sin * {} * A_sin'.format(sid_from) # in [mole/s]
    createKineticLaw(model, r, formula) 

    return r;

'''   
    /** Transport via Diffusion in sinusoids, space of Disse and in between. */
    public static Reaction createDiffusionReaction(Model model, String mId, String cFromId, String cToId, String Dxy) throws ParseException{
        // Get and create necessary ids
        String sFromId = Naming.createLocalizedId(cFromId, mId);
        String sToId = Naming.createLocalizedId(cToId, mId);
        String rId = Naming.createDiffusionId(cFromId, cToId, mId);
        
        // create reaction
        Reaction r = model.createReaction(rId);
        r.setName(rId);
        r.setReversible(true);
        SpeciesReference sref = r.createReactant(model.getSpecies(sFromId));
        sref.setStoichiometry(1.0);
        if (SBMLUtils.SBML_LEVEL > 2){
            sref.setConstant(true);
        }
        if (!cToId.equals("NULL")){
            sref = r.createProduct(model.getSpecies(sToId));
            sref.setStoichiometry(1.0);
            if (SBMLUtils.SBML_LEVEL > 2){
                sref.setConstant(true);
            }
        }
        // create kinetics
        if (!cToId.equals("NULL")){
            ReactionFactory.createKineticLaw(r, String.format("%s * (%s - %s)", Dxy, sFromId, sToId)); // in [mole/s]
        } else {
            ReactionFactory.createKineticLaw(r, String.format("%s * (%s)", Dxy, sFromId)); // in [mole/s]    
        }
        if (SBMLUtils.SBML_LEVEL > 2){
            r.setFast(false);
        }
        System.out.println(String.format("%s -> [%s]\n", r.getId(), r.getDerivedUnits()));
        return r;
    }
'''