import { LightningElement, wire} from 'lwc';
import getArticles from '@salesforce/apex/getArticlesController.getArticles';

export default class DisplayArticles extends LightningElement {

    @wire (getArticles) wiredArticles({data,error}){
        if (data) {
        console.log(data);
        } else if (error) {
        console.log(error);
        }
   }

     
}

