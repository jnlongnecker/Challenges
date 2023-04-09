import { createElement } from 'lwc';
import Challenge7 from 'c/challenge7';

import { getRecord } from 'lightning/uiRecordApi';
const mockContact = require('./data/contactMock.json');

describe('c-challenge7', () => {
    afterEach(() => {
        // The jsdom instance is shared across test cases in a single file so reset the DOM
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    it('populates markup with data', async () => {
        // Arrange
        const element = createElement('c-challenge7', {
            is: Challenge7
        });

        // Act
        document.body.appendChild(element);

        getRecord.emit(mockContact);

        await Promise.resolve();

        const name = element.shadowRoot.querySelector('lightning-card').title;
        const phone = element.shadowRoot.querySelector('lightning-formatted-phone').value;
        const email = element.shadowRoot.querySelector('lightning-formatted-email').value;
        const title = element.shadowRoot.querySelector('lightning-formatted-text').value;

        expect(name).toBe(mockContact.fields.Name.value);
        expect(phone).toBe(mockContact.fields.Phone.value);
        expect(email).toBe(mockContact.fields.Email.value);
        expect(title).toBe(mockContact.fields.Title.value);
    });
});