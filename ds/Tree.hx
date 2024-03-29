package ds;

import ds.TreeNode;

class Tree {
    public var root(default, null): TreeNode;

    public function new(root: TreeNode) {
        this.root = root;
    }

    public inline function iterator(): Iterator<TreeNode> {
        return new TreeIterator(this.root);
    }
}

private class TreeIterator {
    var root: TreeNode;
    var current: TreeNode;
    var start: TreeNode;

    public function new(node: TreeNode) {
        this.root = node;
        this.start = node;
        while (true) {
            if (this.start.first_child == null)
                break;
            this.start = this.start.first_child;
        }  

        this.current = start;
    }

    public function next(): TreeNode {
        var old = this.current;

        if (this.current.next == null) {
            this.current = this.current.parent;
        } else {
            this.current = this.current.next;
            while (this.current.first_child != null)
                this.current = this.current.first_child;
        }

        return old;
    }

    public function hasNext(): Bool {
        return this.current != root;
    }
}