class CfgWeapons {
    class ItemCore;
    class InventoryItem_Base_F;
    class CBA_MiscItem_ItemInfo: InventoryItem_Base_F {
        type = 302; // "bipod"
    };
    class CBA_MiscItem: ItemCore { // type = 131072;
        class ItemInfo: CBA_MiscItem_ItemInfo {};
    };
};
