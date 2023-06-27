import { LightningElement, wire} from 'lwc';
import getArticles from '@salesforce/apex/getArticlesController.getArticles';

export default class DisplayArticles extends LightningElement {

    @wire (getArticles) wiredArticles;
    handleClick(){
        console.log(this.wiredArticles);
    }
}

