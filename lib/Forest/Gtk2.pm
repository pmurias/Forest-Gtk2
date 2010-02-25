# ABSTRACT: display a Forest::Tree as a gtk tree view
use strict;
use warnings;
package Forest::Gtk2;
sub _append_to_tree_store {
    my ($tree,$tree_store,$parent) = @_;
    my $iter = $tree_store->append($parent);
    $tree_store->set($iter,0=>,$tree->node);
    for (@{$tree->children}) {
        _append_to_tree_store($_,$tree_store,$iter);
    }
}
sub tree_to_tree_store {
    my ($tree) = @_;
    my $tree_store = Gtk2::TreeStore->new(qw/Glib::String/);
    _append_to_tree_store($tree,$tree_store);
    $tree_store;
}
sub tree_to_tree_view {
    my ($tree) = @_;
    my $tree_store = tree_to_tree_store($tree);
    my $tree_view = Gtk2::TreeView->new($tree_store);
    $tree_view->append_column (_create_column($0,0));
#    $tree_view->append_column (_create_column('Column 2',1));
    $tree_view;

}
sub _create_column {
    my ($text,$column) = @_;
    my $tree_column = Gtk2::TreeViewColumn->new();
    $tree_column->set_title ($text);
    my $renderer = Gtk2::CellRendererText->new;
    $tree_column->pack_start ($renderer,'FALSE');
    $tree_column->add_attribute($renderer, text => $column);
    $tree_column;
}

1;
