package ds;

class TreeNode {
    public var parent: TreeNode;
    public var first_child: TreeNode;
    public var next: TreeNode;

    public function new() {
        this.first_child = null;
        this.next = null;
    }

    public inline function children(): Iterator<TreeNode> {
        return new ChildrenIterator(this);
    }

    public inline function count(): Int {
        var i: Int = 0;
        for (child in this.children())
            i++;

        return i;
    }

    public function addChild(child: TreeNode): TreeNode {
        if (child.parent != null)
            throw "Node already is a child!";

        child.parent = this;
        child.next = this.first_child;

        this.first_child = child;
        return child;
    }

    public function insertChild(node: TreeNode, index: Int): TreeNode {
        if (node.parent != null)
            throw "Node already is a child!";

        index = toValidIndex(index);

        var i: Int = 0;
        var prev_child: TreeNode = this.first_child;

        for (child in this.children())
            if (i == index) {
                node.parent = this;
                node.next   = prev_child.next;

                prev_child.next = node;

                return node;
            } else {
                prev_child = child;
            }

        throw "Index Out Of Reach!";
    }

    public function removeFirstChild(): TreeNode {
        if (this.first_child == null)
            return null;

        var old: TreeNode = this.first_child;
        this.first_child = this.first_child.next;
        return old.orphan();
    }

    public function removeLastChild(): TreeNode {
        for (child in this.children())
            if (child.next == null)
                return child.orphan();
        return null;
    }

    public function removeChild(index: Int): TreeNode {
        index = toValidIndex(index);

        var i: Int = 0;
        var prevChild: TreeNode = this.first_child;

        for (child in this.children())
            if (i == index) {
                prevChild.next = child.next;
                return child.orphan();
            } else {
                prevChild = child;
            }

        throw "Index Out Of Reach!";
    }

    private inline function toValidIndex(index: Int): Int {
        if (index >= 0)
            return index;
        
        index = this.count() + index;

        if (index < 0)
            throw "cringe";

        return index;
    }

    private inline function orphan(): TreeNode {
        if (this != null) {
           this.parent = null;
           this.next = null;
        }

        return this;
    }
}

private class ChildrenIterator {
    var current: TreeNode;

    public function new(node: TreeNode) {
        this.current = node.first_child;
    }

    public function next(): TreeNode {
        var last: TreeNode = this.current;
        this.current = this.current.next;
        return last;
    }

    public function hasNext(): Bool {
        return this.current != null;
    }
}