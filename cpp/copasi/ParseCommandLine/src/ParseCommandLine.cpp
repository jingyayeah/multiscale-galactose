#include <boost/program_options/options_description.hpp>
#include <boost/program_options/parsers.hpp>
#include <boost/program_options/variables_map.hpp>

namespace po = boost::program_options;

int main(int argc, const char* argv[]){
    po::options_description description("CopasiModelRunner Usage");

    description.add_options()
        ("help,h", "Display this help message")
        ("sbml,s", po::value<std::string>(), "SBML file")
        ("pars,p", po::value<std::string>(), "Parameter file")
        ("version,v", "Display the version number");

    po::positional_options_description pos;
   // pos.add("input-files", -1);

    po::variables_map vm;
    po::store(po::command_line_parser(argc, argv).options(description).positional(pos).run(), vm);
    po::notify(vm);

    // check for options
    if(vm.count("help")){
        std::cout << description;
        return 0;
    }

    if(vm.count("sbml")){
        std::cout << "SBML file: " << vm["sbml"].as<std::string>() << std::endl;
    }

    if(vm.count("pars")){
        std::cout << "Parameter file: " << vm["pars"].as<std::string>() << std::endl;
    }

    if(vm.count("version")){
        std::cout << "CopasiModelRunner Version 1.0" << std::endl;
        return 0;
    }

    return 0;
}
