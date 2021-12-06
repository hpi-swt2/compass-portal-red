# Import Pipeline Indoor Map

### Labeling
- The first step is labeling the image of a room plan. For this you can use the labeling tool https://www.makesense.ai
- For every corner of a room insert a point
- Create a label for each point
- Label Fomat
    - Every room is identified by a letter, the number after the letter is the position of a point in the surrounding polygon
    - A point can be part of a maximum of four rooms. This is why a label is made up of four parts, seperated by commas.
    - Example 1: A1,B2,C4,D6 is the label for a point that is part of rooms A, B, C and D. It is the first point in room A the second point in room B, the fourth point in room C and so on. 
    - Example 2: If a point is part of less than 4 rooms you still need the comma. For example, if a point is only point of A and it is the first point in A, the label would be A1,,,

### Exporting
- In makesense.ai after labeling you can export your points as .csv file

### Importing
- Place your .csv file in app/assets/data
- Import the building by adding the path to the file in the `import_rooms.rb` and running the script with `rails runner app/helpers/import_rooms.rb`
- If you only want to import the already labeled building (importBuilding1.csv) you don't need to change anything and can just run `import_rooms.rb`
- With the import script you can only import one building floor at a time