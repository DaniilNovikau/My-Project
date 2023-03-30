@IsTest
public with sharing class NavigationMenuControllerTest {
    @IsTest
    public static void getNavigationMenuItemsTest() {
        List<ConnectApi.NavigationMenuItem> items = NavigationMenuController.getNavigationMenuItems('Test');
        System.assertEquals(1, items.size());
    }
}