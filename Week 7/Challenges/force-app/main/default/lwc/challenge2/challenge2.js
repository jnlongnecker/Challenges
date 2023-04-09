import { LightningElement } from 'lwc';

export default class Challenge2 extends LightningElement {
    titleValue = 'No Value Yet';

    showInput = false;

    toggleInput() {
        this.showInput = !this.showInput;
    }

    changeTitleValue() {
        this.titleValue = this.refs.input.value;
    }
}