PREPMAIN(addBISEventHandler);
PREPMAIN(addPlayerEventHandler);
PREPMAIN(removePlayerEventHandler);
PREPMAIN(addDisplayHandler);
PREPMAIN(removeDisplayHandler);
PREPMAIN(addKeyHandler);
PREPMAIN(addKeyHandlerFromConfig);
PREPMAIN(readKeyFromConfig);
PREPMAIN(changeKeyHandler);
PREPMAIN(removeKeyHandler);
PREPMAIN(addEventHandler);
PREPMAIN(addEventHandlerArgs);
PREPMAIN(removeEventHandler);
PREPMAIN(localEvent);
PREPMAIN(globalEvent);
PREPMAIN(globalEventJIP);
PREPMAIN(removeGlobalEventJIP);
PREPMAIN(serverEvent);
PREPMAIN(remoteEvent);
PREPMAIN(targetEvent);
PREPMAIN(turretEvent);
PREPMAIN(ownerEvent);
PREPMAIN(addMarkerEventHandler);
PREPMAIN(removeMarkerEventHandler);
PREPMAIN(registerChatCommand);
PREPMAIN(weaponEvents);

if (hasInterface) then {
      PREP(playerEvent);

      // Key Handlers
      PREP(keyHandler);
      PREP(keyHandlerDown);
      PREP(keyHandlerUp);
      PREP(mouseHandlerDown);
      PREP(mouseHandlerUp);
      PREP(mouseWheelHandler);
      PREP(userKeyHandler);
};
