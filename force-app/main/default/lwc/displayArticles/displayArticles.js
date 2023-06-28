import { LightningElement, wire, track} from 'lwc';
import getArticles from '@salesforce/apex/getArticlesController.getArticles';

export default class DisplayArticles extends LightningElement {

    @wire (getArticles) wiredArticles;
    handleClick(){
        // redirect to the article page
        console.log(this.wiredArticles);

    }
    // filter data based on search
    searchKey;
    // @track means if any change in searchKey then it will reflect in wiredArticles
    @track wiredArticles;
    //This Funcation will get the value from Text Input.
    handelSearchKey(event){
        this.searchKey = event.target.value;
        getArticles(this.searchKey)
    }

    //This funcation will fetch the Account Name on basis of searchkey
    SearchArticlesHandler(){
        //call Apex method.
        getArticles({textkey: this.searchKey})
        .then(result => {
            this.wiredArticles = result;

        })
        .catch( error=>{
            console.log('Error Occured',error);
        });

    }
    // handleSearch(event){
    //     console.log(event.target.value);
    //     const searchKey = event.target.value.toLowerCase();
    //     const articles = this.wiredArticles.data;
    //     const filteredArticles = articles.filter(article => {
    //         return article.article.Title.toLowerCase().includes(searchKey);
    //     });
    //     this.wiredArticles.data = filteredArticles;
    // }
}