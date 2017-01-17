# Changes being done to prepare for moving data to new system.

Changes are being made in recipes_new.dtd to handle new data format.

Simplifying data model for transfering to new encoding format.

-   Removing all XML entities defined in the DTD.
    -   Most systems now handle special characters (E.g., degree symbol and
        trademark symbol) directly.
    -   Plan on moving to a different input format where entities are not
        handled.
-   Simplified 'recipes' element to only hold 'recipe' elements.
    -   The other items were for making books of recipes and not
        needed for the transfer.
-   Removed 'background' as 'comment' can include background.
-   Removed 'emph' (emphasis).
