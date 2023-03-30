import { api, LightningElement, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

import getNavigationMenuItems from '@salesforce/apex/NavigationMenuController.getNavigationMenuItems';
import getUserSession from '@salesforce/apex/NavigationMenuController.getUserSession';

import basePath from "@salesforce/community/basePath";

export default class NavigationMenu extends LightningElement {
    @api navigationMenuName = 'Default_Navigation';

    navigationMenuItems;

    get logoutLink() {
        const sitePrefix = basePath.replace(/\/s$/i, "");
        return sitePrefix + "/secur/logout.jsp";
    }

    @wire(getNavigationMenuItems, { navigationMenuName: '$navigationMenuName'})
    wiredNavigationMenuItems({error, data}) {
        if (data) {
            this.navigationMenuItems = data;
        } else if (error) {
            console.error(error);
        }
    }

    @wire(getUserSession)
    wiredUserSession({ error, data }) {
        if (data) {
            this.isUserLoggedIn = data;
            console.log(data);
        } else if (error) {
            console.error(error);
        }
    }

    navigate(event) {
        console.log(event.currentTarget.dataset.link);
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: event.currentTarget.dataset.link
            }
        }, false);
    }
}