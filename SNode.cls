/**
 * SNode - Written by Jacob Schultz 13.4.16
 * 
 * A simple node class used by the Apex Linked List class.
 * This node will hold any SObject (User, Opp, Case, Etc.)
 * It will also hold a value/weight/index - whatever int you would like
 * Since the LinkedList is a doubly linkedlist there are also fields
 * for the next and previous node.
 * 
 */
public class SNode {
    
    private SObject obj;
    private Integer value;
    private SNode previous; 
    private SNode next;
    
    public SNode(){
        this.obj = null;
        this.value = 0;
        this.previous = null;
        this.next = null;
    }
    
    public SNode(SObject obj, Integer value){
        this.obj = obj;
        this.value = value;
    }
    
    public SObject getObject(){
        return this.obj; 
    }
    
    public Integer getValue(){
        return this.value;
    }
    
    public void setObject(SObject obj){
        this.obj = obj;
    }
    
    public void setValue(Integer i){
        this.value = i;
    }
    
    public void setNext(SNode n){
        this.next = n;
    }
    
    public void setPrevious(SNode p){
        this.previous = p;
    }
    
    public SNode getPrevious(){
        return this.previous;
    }
    
    public SNode getNext(){
        return this.next;
    }
}