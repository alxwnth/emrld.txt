import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="tasks"
export default class extends Controller {
    connect() {
    }s

    toggle(e) {
        const id = e.target.dataset.id
        const csrfToken = document.querySelector("[name='csrf-token']").content

        fetch(`/tasks/${id}/toggle`, {
            method: 'POST', // *GET, POST, PUT, DELETE, etc.
            mode: 'cors', // no-cors, *cors, same-origin
            cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
            credentials: 'same-origin', // include, *same-origin, omit
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-Token': csrfToken
            },
            body: JSON.stringify({completed: e.target.checked}) // body data type must match "Content-Type" header
        })
            // TODO: There should be a better way, right?
            .then(function () {
                const frame = document.getElementById('task_' + id);
                frame.src = frame.baseURI;
            })
    }

}
