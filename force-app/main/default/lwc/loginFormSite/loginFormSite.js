import { LightningElement } from 'lwc';
const STATIC_RESOURCES_PATH = '/sfsites/c/resource/';

export default class LoginFormSite extends LightningElement {

    connectedCallback() {
        var cssStyles = document.body.style;
        let backgroundLink = STATIC_RESOURCES_PATH + 'images/loginForm.jpg';
        cssStyles.setProperty('--backgroundImageLink', 'url(\'' + backgroundLink + '\')');
    }
}