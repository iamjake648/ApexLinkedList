/**
 * LinkedList - Written by Jacob Schultz 13.4.16
 * A simple double linked list class written in apex
 * This LL allows you to store SObjects and values/weights, and then add
 * them in order to a list and keep them sorted - unlike a map.
 * 
 * #TODO: Methods
 * -Merge Sort
 * -Delete by Object
 * -Delete by Value
 * 
 * This is still under development, and is subject to change.
 * This could also be easily modified to store Lists of SObjects
 */
public class LinkedList {
    
    private SNode head;
    private Integer size; 
    private SNode tail;
    /**
     * Constructor - Creates a new Linked List
     */
    public LinkedList(){
        this.head = null;
        this.size = 0;
    }
    
    /**
     * addToList - Creates a new SNode from an SObject and value,
     * and then adds it to the list NOT IN ORDER, just adds to the end.
     * @param SObject obj - Any SObject (User, Case, Opp, etc.)
     * @param Int value - A weight or index to give the SObject 
     */
    public void addToList(SObject obj, Integer value){
        //Create a new SNode
        SNode n = new SNode(obj, value);
        Snode temp = this.head;
        
        //First Item in the List
        if (temp == null){
            head = n;
        } else {
            //Walk to the end of the list
            while(temp.getNext() != null){
                temp = temp.getNext();
            }
            //Add to the end of the list
            temp.setNext(n);
            n.setPrevious(temp);
        }
        //Increase the size of the list
        this.size++;
    }
    
    /**
     * deleteAtIndex - Deletes an SNode at a given Index
     * Walks down the list until it reaches the index provided, 
     * then deletes the SNode and retains list order. 
     * @param Int i - Index to delete at 
     */
    public void deleteAtIndex(Integer i){
        //Make sure that index is in the list
        if (i < getSize()){
            SNode temp = this.head;
            Integer c = 0;
            //Walk down the list to the index
            while (c < i){
                c++;
                temp = temp.getNext();
            }
            
            SNode toDelete = temp;
            //Remove from list by changing the two nodes around it
            toDelete.getPrevious().setNext(toDelete.getNext());
            toDelete.getNext().setPrevious(toDelete.getPrevious());
            //Set the old objects to null
            temp = null;
            toDelete = null;
        } else {
            System.debug('Unable to delete at this index.');
        }
    }
    
    /**
     * addInOrder - Creates a new SNode and adds it to the list in order
     * This allows the list to remain sorted, without
     * ever calling a sort method. 
     * @param SObject obj - Any SObject (User, Case, Opp, etc.)
     * @param Int value - A weight or index to give the SObject
     */ 
    public void addInOrder(SObject obj, Integer value){
        SNode n = new SNode(obj, value);
        Snode temp = this.head;
        
        //First Item in the List
        if (temp == null){
            head = n;
        } else {
            Integer depth = 0;
            //Walk down the list
            while (temp.getNext() != null && temp.getValue() < value){
               temp = temp.getNext();
               depth++;
            }
            //If the value is less than the head
            if (depth == 0){
                //Add after head
                if (n.getValue() > temp.getValue()){
                    n.setPrevious(temp);
                    n.setNext(temp.getNext());
                    temp.setNext(n); 
                //New Head
                } else {
                   n.setNext(temp);
                   temp.setPrevious(n);
                   this.head = n;
                }
            } else {
                //Adding in the middle
                if (temp.getNext() != null){
                    addToListInOrder(n, temp);
                //Adding at the end
                } else {
                    if (value > temp.getValue()){
                        //Adding at the end
                        temp.setNext(n);
                        n.setPrevious(temp);
                    } else {
                        //Add before the end
                        addToListInOrder(n, temp);
                    }
                }
            }
        }
        //Increase the size
        this.size++;
    }
    
    
    
    /**
     * addToListInOrder - A simple helper method used by the addInOrderMethod
     * This helper method handles reassociating the relationships
     * when adding between two SNodes in the list.
     */ 
    private void addToListInOrder(SNode n, SNode temp){
         temp.getPrevious().setNext(n);
         n.setNext(temp);
         n.setPrevious(temp.getPrevious());
         temp.setPrevious(n);
    }
    
    /**
     * debugList - Prints the List to the salesforce Dev Console
     * Should be used when debugging the list
     */ 
    public void debugList(){
        SNode temp = this.head;
        Integer i = 0;
        System.debug('List' + i + ' : ' + temp.getValue() + ' ' + temp.getObject());
        while (temp.getNext() != null){
            temp = temp.getNext();
            i++;
            System.debug('List' + i + ' : ' + temp.getValue() + ' ' + temp.getObject());
        }
        System.debug('================================================================');
    }
    
    
    public Integer getSize(){
        return this.size;
    }
    
    /**
     * convertToList
     * This method converts a LinkedList to a stanard
     * salesforce list. Only SObject data is presevered,
     * value is dropped.
     */
    public List<SObject> convertToList(){
        List<SObject> l = new List<SObject>();
        SNode temp = this.head;
        //Walk the linkedlist and add every item to a apex list
        while (temp.getNext() != null){
            l.add(temp.getObject());
            temp = temp.getNext();
        }
        return l;
    }
    
    /**
     * convertToListDesc 
     * This method converts a LinkedList to a standard Apex
     * list, and then loops through backwards, so the larger 
     * objects are returned first.
     */
    public List<SObject> convertToListDesc(){
        List<SObject> l = new List<SObject>();
        SNode temp = this.head;
        //Walk the list and add all objects to a list
        while (temp.getNext() != null){
            l.add(temp.getObject());
            temp = temp.getNext();
        }
        
        List<SObject> ld = new List<Sobject>();
        //Start at the end and walk backwards
        for (Integer i = l.size()-1; i >=0; i--){
            ld.add(l.get(i));
        }
        return l;
    }
    
    /**
     * bubbleSort - A simple method to sort the linkedList
     * Bubble sort has a runtime of n^2 where n is the number of elements.
     */ 
    public void bubbleSort(){
        //Tracker variable to check if the list has been sorted
        boolean done = false; 
        while (!done) {
            //Temp node to walk the list
            SNode temp = head;
            done = true;
            //Loop the list
            for (Integer i = 0; i < getSize() -1; i++){
                //Check the current node and the next node's value
                if (temp.getNext().getValue() < temp.getValue()) {
                    //If next is less, than swap them
                    swap(temp, temp.getNext());
                    done = false;
                }
                //Continue down the list
                temp = temp.getNext();
            }
        }
    
    }
    
    /**
     * swap - Used by bubble sort to swap node values objects.
     */ 
    private void swap(SNode a, SNode b){
        //Temp variables to store a's values. 
        Integer i = a.getValue();
        SObject s = a.getObject();
        //Switch the values
        a.setValue(b.getValue());
        a.setObject(b.getObject());
        b.setValue(i);
        b.setObject(s);
    }
    
    public boolean isEmpty(){
        if (getSize() > 0){
            return false;
        } else {
            return true;
        }
    }
    
}