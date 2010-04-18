#include "script_component.hpp"

LOG(MSG_INIT);

ADDON = false;

PREP(doc);
PREP(doc_init);
PREP(help);
PREP(describe);

call FUNC(doc_init);

ADDON = true;
