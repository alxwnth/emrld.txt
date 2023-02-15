# emrld.txt 

emrld.txt is a simple self-hosted to-do list web app compatible with [todo.txt](http://todotxt.org/) format.

<img src="screenshot.png">

# Advantages

- Simple, minimalistic, and lightweight
- Contexts and projects with filtering
- Keyword search
- Tasklog with all completed tasks. Completed tasks can be purged in one click
- Batch add tasks/import
- Export

# Run

The easiest way is to just run a Docker container

`docker run -it -p 3000:3000 alxwnth/emrld.txt:0.1.0`

Also you can run it with Rails

`rails server`

_Keep in mind that neither of this options are optimized for production._

# To-do

- [ ] Night mode
- [ ] Proper mobile version
- [ ] Combining project and context tags
- [ ] More advanced search
- [ ] Due dates
- [ ] Markdown links
- [ ] Encryption
- [ ] Keyboard-based workflow