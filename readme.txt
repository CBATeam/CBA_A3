CBA: Community Base Addons
==========================

Online wiki at http://dev-heaven.net/projects/cca/wiki
Online function library reference at http://dev-heaven.net/docs/cba/

@CBA                                  => Copy this directory to your Arma II game directory (see manual for more details).
@CBA_OA                               => Copy this as well, but only if you have Operation Arrowhead content.
@CBA_A2                               => Copy this as well, but only if you have ARMA2 original content. 
@CBA_TOH                              => Copy this as well, but only if you have Take on Helicopters content. 
@CBA/store/wiki.tar                   => Tar archive of the online wiki. This is a copy of the DevHeaven wiki at the time of release.
@CBA/store/function_library.tar       => Tar archive of the the function/macro reference.
@CBA/store/keys/                      => Server keys for addons.
@CBA/store/source/                    => Source files for all addons.

License details included in license.txt


What do I need?
===============
* You should always install the @CBA mod folder by copying it to your ArmA II installation
  folder,

* If you have ARMA2 Original (Standalone, or combined with Operation Arrowhead or Take on Helicopters),
  you need to also install @CBA_A2

* If you have Operation Arrowhead expansion (Standalone, or combined with ARMA2 or Take on Helicopters),
  you need to also install @CBA_OA

* If you have Take on Helicopters (Standalone, or combined with ARMA2 or Operation Arrowhead),
  you need to also install @CBA_TOH


Example startup parameters
==========================

For ARMA 2 Content

    -mod=@CBA;@CBA_A2


For Operation Arrowhead Content

    -mod=@CBA;@CBA_OA


For Take on Helicopters Content

    -mod=@CBA;@CBA_TOH


For Combined Operations (A2 + OA):

    -mod=@CBA;@CBA_A2;@CBA_OA

For Take on Rearmed (A2 + OA + TakeOn):

    -mod=arma2;arma2 oa;arma2 oa\expansion;take on;beta;@CBA;@CBA_A2;@CBA_OA;@CBA_TOH
