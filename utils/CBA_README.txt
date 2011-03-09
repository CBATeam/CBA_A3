CBA: Community Base Addons
==========================

Online wiki at http://dev-heaven.net/wiki/cca/
Online function library reference at http://dev-heaven.net/docs/cba/

@CBA                                  => Copy this directory to your Arma II game directory (see manual for more details).
@CBA_OA                               => Copy this aswell, but only if you have a standalone Operation Arrowhead installation.
@CBA_A2                               => Copy this if you have ArmA II but not Arrowhead. 
@CBA/store/wiki.tar                   => Tar archive of the online wiki. This is a copy of the DevHeaven wiki at the time of release.
@CBA/store/function_library.tar       => Tar archive of the the function/macro reference.
@CBA/store/keys/                      => Server keys for addons.
@CBA/store/source/                    => Source files for all addons.



What do I need?
===============
* You should always install the @CBA mod folder by copying it to your ArmA II installation
  folder.

* If you have a "merged" or "seperate", Combined Operations installation with both the old ArmA II
  content and the new Arrowhead expansion, you're done - you only need the @CBA mod folder.

* If you only have a standalone Operation Arrowhead installation, you need both the @CBA
  and the @CBA_OA folders loaded.
  
* If you only have the older ArmA II installed, you need both the @CBA and the
  @CBA_A2 folders loaded.



Example startup parameters
==========================

For Combined Operations (ArmA II and Arrowhead launched together):

    -mod=@CBA


For a standalone Operation Arrowhead:

    -mod=@CBA;@CBA_OA


For ArmA II only (people without Arrowhead):

    -mod=@CBA;@CBA_A2
