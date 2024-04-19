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
    year TEXT,
    type TEXT
);

-- Quote table
CREATE TABLE Quote (
    quoteID INTEGER PRIMARY KEY,
    srcID INTEGER,
    text TEXT,
    authID INTEGER,
    FOREIGN KEY (srcID) REFERENCES Source(sourceID),
    FOREIGN KEY (authID) REFERENCES Author(authorID)
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

-- User table
CREATE TABLE User (
    email TEXT PRIMARY KEY,
    password TEXT,
    username TEXT
);

-- Image table
CREATE TABLE Image (
    imageID INTEGER PRIMARY KEY,
    imageURL TEXT
);
