import { LightningElement, wire} from 'lwc';
import getArticles from '@salesforce/apex/getArticlesController.getArticles';

export default class DisplayArticles extends LightningElement {

    @wire (getArticles) wiredArticles;
    handleClick(){
        console.log(this.wiredArticles);
    }
    // filter data based on search
    handleSearch(event){
        console.log(event.target.value);
        const searchKey = event.target.value.toLowerCase();
        const articles = this.wiredArticles.data;
        const filteredArticles = articles.filter(article => {
            return article.article.Title.toLowerCase().includes(searchKey);
        });
        this.wiredArticles.data = filteredArticles;
    }
}