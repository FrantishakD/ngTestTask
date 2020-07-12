import { LightningElement, track, wire, api } from 'lwc';
import getImages from '@salesforce/apex/ImageDisplayController.getImages';
import sendEmail from '@salesforce/apex/ImageDisplayController.sendEmail';

export default class ImagesDisplay extends LightningElement {
    allImages = [];
    filter;
    @track page = 1;
    perpage = 18;
    @track pages = [];
    @track email;

    @wire(getImages)
    retrieveImages({error, data}){
        if(data){
            this.allImages = data;
            this.setPages();
            console.log(data.length);
        } else if(error){
            console.error(error);
        }
    }

    @api
    get filteredData(){
        if(this.filter){
            return this.allImages.filter(image => {
                return image.Name.includes(this.filter);
            })
        }
        return this.allImages;
    }

    setPages(){
        this.pages = [];
        let numberOfPages = Math.ceil(this.filteredData.length / this.perpage);
        for (let index = 1; index <= numberOfPages; index++) {
            this.pages.push(index);
        }
    }

    @api
    get pageData(){
        let page = this.page;
        let perpage = this.perpage;
        let startIndex = (page*perpage) - perpage;
        let endIndex = (page*perpage);
        return this.filteredData.slice(startIndex,endIndex);
    }

    handleKeyUp(evt) {
        const isEnterKey = evt.keyCode === 13;
        if (isEnterKey) {
            this.filter = evt.target.value;
            this.setPages();
        }
    }

    @api
    get hasPrev(){
        return this.page > 1;
    }
    
    @api
    get hasNext(){
        console.log('has next' + this.page + ' ' + this.pages.length);
        return this.page < this.pages.length
    }

    onNext(){
        ++this.page;
    }

    onPrev(){
        --this.page;
    }

    onPageClick(e){
        this.page = parseInt(e.target.dataset.id,10);        
    }

    emailChange(event){
        this.email = event.target.value;
    }

    handleSend(){
        if(this.email){
            sendEmail({images : this.filteredData, email : this.email}).then(console.log('success')).catch(e => console.error(e));
        }
    }
}