public with sharing class NavigationMenuController {
    @AuraEnabled(cacheable=true)
    public static List<ConnectApi.NavigationMenuItem> getNavigationMenuItems(String navigationMenuName) {
        List<ConnectApi.NavigationMenuItem> items = new List<ConnectApi.NavigationMenuItem>();
        List<ConnectApi.NavigationMenuItemType> menuItemsToSkip = new List<ConnectApi.NavigationMenuItemType>{
            ConnectApi.NavigationMenuItemType.Event,
            ConnectApi.NavigationMenuItemType.GlobalAction,
            ConnectApi.NavigationMenuItemType.SystemLink
        };

        if (Test.isRunningTest()) {
            ConnectApi.NavigationMenuItem menu1 = new ConnectApi.NavigationMenuItem();
            menu1.label = 'Home';
            menu1.actionType = ConnectApi.NavigationMenuItemActionType.INTERNALLINK;
            menu1.target = ConnectApi.NavigationMenuItemOpenTarget.CURRENTWINDOW;
            menu1.subMenu = new List<ConnectApi.NavigationMenuItem>();
            items.add(menu1);
        } else {
            
            ConnectApi.NavigationMenuItemCollection menu = ConnectApi.NavigationMenu.getCommunityNavigationMenu(Network.getNetworkId(),
            null, navigationMenuName, ConnectApi.PublishStatus.Live,
            false, true, menuItemsToSkip);

            items = menu.menuItems;
        }

        return items;
    }

    @AuraEnabled
    public static Boolean getUserSession(){
        return UserInfo.getUserType() != 'Guest' ? true : false;
    }
}