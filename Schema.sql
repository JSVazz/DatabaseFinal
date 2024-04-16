-- Author table
CREATE TABLE Author (
    authorID INTEGER PRIMARY KEY,
    name TEXT,
    occupation TEXT
);

-- Source table
CREATE TABLE Source (
    sourceID INTEGER PRIMARY KEY,
    author TEXT,
    year INTEGER,
    type TEXT
);

-- Quote table
CREATE TABLE Quote (
    quoteID INTEGER PRIMARY KEY,
    sourceID INTEGER,
    text TEXT,
    authorID INTEGER,
    FOREIGN KEY (sourceID) REFERENCES Source(sourceID),
    FOREIGN KEY (authorID) REFERENCES Author(authorID)
);

-- Category table
CREATE TABLE Category (
    categoryID INTEGER PRIMARY KEY,
    categoryName TEXT,
    description TEXT
);

-- QuoteCategory linking table
CREATE TABLE QuoteCategory (
    quoteID INTEGER,
    categoryID INTEGER,
    PRIMARY KEY (quoteID, categoryID),
    FOREIGN KEY (quoteID) REFERENCES Quote(quoteID),
    FOREIGN KEY (categoryID) REFERENCES Category(categoryID)
);

-- Feedback table
CREATE TABLE Feedback (
    feedbackID INTEGER PRIMARY KEY,
    dateSubmitted INTEGER,
    comment TEXT,
    quoteID INTEGER,
    FOREIGN KEY (quoteID) REFERENCES Quote(quoteID)
);

-- User table
CREATE TABLE User (
    email TEXT PRIMARY KEY,
    password TEXT,
    username TEXT
);

-- UserFeedback linking table
CREATE TABLE UserFeedback (
    email TEXT,
    feedbackID INTEGER,
    PRIMARY KEY (email, feedbackID),
    FOREIGN KEY (email) REFERENCES User(email),
    FOREIGN KEY (feedbackID) REFERENCES Feedback(feedbackID)
);
