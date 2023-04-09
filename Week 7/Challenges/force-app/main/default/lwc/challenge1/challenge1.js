import { LightningElement, track } from 'lwc';

export default class Challenge1 extends LightningElement {
    @track
    itemList = [];

    addInput() {
        this.itemList.push(this.refs.input.value);
    }
}