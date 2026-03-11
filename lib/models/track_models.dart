// ─── Data Models ─────────────────────────────────────────────────────────────

class TrackModel {
  final String id;
  final String title;
  final String description;
  final String level;
  final int lessonsCount;
  final List<String> aboutPoints;
  final List<LessonModel> lessons;

  const TrackModel({
    required this.id,
    required this.title,
    required this.description,
    required this.level,
    required this.lessonsCount,
    required this.aboutPoints,
    required this.lessons,
  });
}

class LessonModel {
  final String id;
  final String title;
  final String content;
  final List<QuizQuestion> quiz;

  const LessonModel({
    required this.id,
    required this.title,
    required this.content,
    required this.quiz,
  });
}

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;

  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
  });
}

// ─── Sample Data ──────────────────────────────────────────────────────────────

const kSampleTracks = [
  TrackModel(
    id: 'html-fundamentals',
    title: 'HTML Fundamentals: Build Your First Web Pages from Scratch',
    description:
        'HTML (HyperText Markup Language) is the backbone of every website on the internet — it defines the structure and content of web pages, from headings and paragraphs to images, links, and tables. Without HTML, there is no web. This beginner-friendly track is designed to take you from zero knowledge to confidently building structured, well-formatted web pages.',
    level: 'Beginner',
    lessonsCount: 10,
    aboutPoints: [
      'This track is designed for absolute beginners — no prior coding experience is needed. You will start from the very basics of what HTML is and gradually build up to writing fully structured web pages on your own.',
      'HTML is the foundation of every website on the internet. By completing this track, you will understand how browsers read and render HTML files and how every webpage you visit is built from the ground up.',
      'The track follows a hands-on, practical approach — each lesson introduces a new concept with real code examples so you can immediately see the results of what you write in a browser.',
      'By the end of this track, you will be able to create well-structured web pages using headings, paragraphs, links, images, tables, lists, and formatted text, and you will understand how HTML connects with CSS and JavaScript.',
      'This HTML track is the essential first step in your web development journey — completing it will prepare you to move confidently into CSS for styling and JavaScript for interactivity.',
    ],
    lessons: [
      LessonModel(
        id: 'html-intro',
        title: 'HTML Introduction',
        content: '''# What is HTML?

HTML stands for HyperText Markup Language. It is the standard language used to create and structure content on the web. Every website you visit — from Google to YouTube — is built using HTML. At its core, HTML is not a programming language; it is a markup language, which means it uses special tags to describe the structure and meaning of content rather than executing logic or calculations.

## A Brief History of HTML

HTML was invented by Tim Berners-Lee in 1991 while working at CERN. The first version supported only a handful of tags. HTML 2.0 was published in 1995 as the first official standard. HTML 4.01 arrived in 1999 and became widely adopted. In 2014, HTML5 was officially published by the World Wide Web Consortium (W3C), introducing powerful features for native video, audio, canvas graphics, local storage, and semantic elements. HTML5 is the version used today and continues to be refined.

## How HTML Works

When you type a URL into your browser, the browser sends a request to a web server. The server responds by sending back an HTML file. The browser then reads (parses) this HTML file from top to bottom and renders the visual page you see on screen.

## Understanding HTML Tags

HTML uses tags to mark up content. A tag is a keyword enclosed in angle brackets `<` and `>`. Most HTML elements have an opening tag and a closing tag. The closing tag includes a forward slash before the keyword.

## Key Takeaways

HTML is the standard markup language for creating web pages. It uses tags enclosed in angle brackets to define the structure of content. Every HTML document starts with a DOCTYPE declaration, an html root element, a head section for metadata and a body section for visible content. HTML is not a programming language — it defines structure and content. It works together with CSS and JavaScript to create the modern web.''',
        quiz: [
          QuizQuestion(
            question: 'What does HTML stand for?',
            options: ['Hyper Text Markup Language', 'High Text Making Language', 'Hyper Text Making Links', 'Hyper Transfer Markup Language'],
            correctIndex: 0,
          ),
          QuizQuestion(
            question: 'Which character is used to begin a closing HTML tag?',
            options: ['!', '/', '?', '#'],
            correctIndex: 1,
          ),
          QuizQuestion(
            question: 'What is the correct DOCTYPE declaration for HTML5?',
            options: ['<!DOCTYPE HTML>', '<!DOCTYPE html5>', '<!DOCTYPE HTM>', '<?xml version="1.0">'],
            correctIndex: 0,
          ),
          QuizQuestion(
            question: 'Which section of an HTML document contains content visible in the browser?',
            options: ['<head>', '<header>', '<body>', '<title>'],
            correctIndex: 2,
          ),
          QuizQuestion(
            question: 'Who invented HTML?',
            options: ['Tim Berners-Lee', 'Bill Gates', 'Linus Torvalds', 'Steve Jobs'],
            correctIndex: 0,
          ),
        ],
      ),
      LessonModel(
        id: 'html-editors',
        title: 'HTML Editors',
        content: '''# HTML Editors

An HTML editor is a software application for writing and editing HTML code. You can write HTML in any plain text editor, but dedicated code editors offer features like syntax highlighting, auto-completion, and error detection.

## Popular HTML Editors

**VS Code** — Visual Studio Code is the most popular free code editor made by Microsoft. It supports all major programming languages and has thousands of extensions.

**Sublime Text** — A lightweight, fast editor with a clean interface. Popular among developers for its speed and multi-cursor editing.

**Notepad++** — A free, open-source editor for Windows. Simple but powerful with syntax highlighting for HTML.

**WebStorm** — A professional IDE by JetBrains focused on web development. Paid but very powerful.

## Online Editors

**CodePen** — A social development environment for front-end designers and developers. Great for quick experiments.

**JSFiddle** — Online playground for HTML, CSS, and JavaScript.

**Replit** — A full online IDE that supports many languages including HTML.

## Key Takeaways

Choose an editor that suits your workflow. VS Code is recommended for beginners due to its large community, free extensions, and excellent documentation.''',
        quiz: [
          QuizQuestion(
            question: 'Which editor is made by Microsoft?',
            options: ['Sublime Text', 'VS Code', 'Notepad++', 'WebStorm'],
            correctIndex: 1,
          ),
          QuizQuestion(
            question: 'What feature do code editors provide that plain text editors do not?',
            options: ['Internet access', 'Syntax highlighting', 'Email support', 'Cloud storage'],
            correctIndex: 1,
          ),
          QuizQuestion(
            question: 'Which online editor is described as a social development environment?',
            options: ['JSFiddle', 'Replit', 'CodePen', 'WebStorm'],
            correctIndex: 2,
          ),
        ],
      ),
      LessonModel(
        id: 'html-basic',
        title: 'HTML Basic',
        content: '''# HTML Basic Structure

Every HTML document follows a standard structure. Understanding this structure is the first step to writing valid web pages.

## The Basic Template

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <title>My First Page</title>
  </head>
  <body>
    <h1>Hello, World!</h1>
    <p>This is my first web page.</p>
  </body>
</html>
```

## Key Elements

**DOCTYPE** — Tells the browser which version of HTML is being used. `<!DOCTYPE html>` is for HTML5.

**html** — The root element that wraps the entire document.

**head** — Contains metadata: title, character encoding, CSS links, and scripts.

**body** — Contains all visible content: headings, paragraphs, images, links, etc.

## Headings

HTML has 6 levels of headings from `<h1>` (most important) to `<h6>` (least important).

## Paragraphs

The `<p>` tag defines a paragraph. Browsers automatically add space before and after paragraphs.

## Key Takeaways

Every HTML file needs DOCTYPE, html, head, and body. The head holds metadata and the body holds visible content.''',
        quiz: [
          QuizQuestion(
            question: 'How many heading levels does HTML have?',
            options: ['3', '4', '6', '8'],
            correctIndex: 2,
          ),
          QuizQuestion(
            question: 'Which tag defines a paragraph in HTML?',
            options: ['<text>', '<para>', '<p>', '<pg>'],
            correctIndex: 2,
          ),
          QuizQuestion(
            question: 'What does the <head> element contain?',
            options: ['Visible content', 'Metadata', 'Images', 'Navigation'],
            correctIndex: 1,
          ),
        ],
      ),
    ],
  ),
  TrackModel(
    id: 'css-basics',
    title: 'CSS Basics: Style Your Web Pages',
    description:
        'CSS (Cascading Style Sheets) controls the visual presentation of HTML documents. Learn how to add colors, fonts, layouts, and animations to your web pages. This track covers selectors, the box model, flexbox, and responsive design.',
    level: 'Beginner',
    lessonsCount: 8,
    aboutPoints: [
      'CSS is what makes websites beautiful. Without CSS, every website would look like a plain text document with no colors or layout.',
      'You will learn how to select HTML elements and apply styles to them using a variety of selector types.',
      'The box model is a fundamental concept in CSS that describes how elements are sized and spaced on a page.',
      'Flexbox is a powerful layout system that makes it easy to create responsive designs without complex calculations.',
      'By the end of this track, you will be able to style complete web pages and make them responsive for mobile devices.',
    ],
    lessons: [
      LessonModel(
        id: 'css-intro',
        title: 'CSS Introduction',
        content: '''# What is CSS?

CSS stands for Cascading Style Sheets. It is the language used to style and visually format HTML documents. While HTML defines the structure and content of a web page, CSS controls how that content looks — including colors, fonts, spacing, sizing, layout, and animations.

## How CSS Works

CSS works by selecting HTML elements and applying visual rules to them. A CSS rule consists of a selector and a declaration block.

```css
h1 {
  color: blue;
  font-size: 24px;
}
```

## Ways to Add CSS

**Inline** — Added directly to an HTML element using the style attribute.
**Internal** — Added inside a `<style>` tag in the HTML head.
**External** — Written in a separate .css file and linked to the HTML.

## Key Takeaways

CSS separates content from presentation. External stylesheets are best practice for maintainability.''',
        quiz: [
          QuizQuestion(
            question: 'What does CSS stand for?',
            options: ['Cascading Style Sheets', 'Creative Style System', 'Computer Style Sheets', 'Colorful Style Syntax'],
            correctIndex: 0,
          ),
          QuizQuestion(
            question: 'Which method of adding CSS is considered best practice?',
            options: ['Inline', 'Internal', 'External', 'All are equal'],
            correctIndex: 2,
          ),
        ],
      ),
    ],
  ),
  TrackModel(
    id: 'python-intro',
    title: 'Python for Beginners: Learn Programming from Zero',
    description:
        'Python is one of the most popular programming languages in the world. It is used in web development, data science, artificial intelligence, automation, and more. This track teaches you Python from scratch with practical examples.',
    level: 'Intermediate',
    lessonsCount: 12,
    aboutPoints: [
      'Python is beginner-friendly with a simple, readable syntax that resembles plain English.',
      'You will learn variables, data types, conditions, loops, functions, and object-oriented programming.',
      'Python is used by companies like Google, Netflix, Instagram, and NASA.',
      'Each lesson includes hands-on coding exercises to reinforce what you learn.',
      'By the end, you will be able to write Python programs to automate tasks and solve real problems.',
    ],
    lessons: [
      LessonModel(
        id: 'python-intro-lesson',
        title: 'Introduction to Python',
        content: '''# Introduction to Python

Python is a high-level, interpreted programming language known for its simplicity and readability. Created by Guido van Rossum and first released in 1991, Python has grown to become one of the most widely used languages in the world.

## Why Learn Python?

Python is used in web development, data science, machine learning, automation, scientific computing, game development, and more. Its syntax is clean and easy to read, making it an excellent first language for beginners.

## Your First Python Program

```python
print("Hello, World!")
```

## Variables

```python
name = "Ahmed"
age = 25
is_student = True
```

## Key Takeaways

Python is versatile, beginner-friendly, and in high demand. It is an excellent choice as a first programming language.''',
        quiz: [
          QuizQuestion(
            question: 'Who created Python?',
            options: ['James Gosling', 'Guido van Rossum', 'Brendan Eich', 'Linus Torvalds'],
            correctIndex: 1,
          ),
          QuizQuestion(
            question: 'What function is used to display output in Python?',
            options: ['console.log()', 'System.out.println()', 'print()', 'echo()'],
            correctIndex: 2,
          ),
        ],
      ),
    ],
  ),
];