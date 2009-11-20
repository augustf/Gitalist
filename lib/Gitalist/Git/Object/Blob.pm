package Gitalist::Git::Object::Blob;
use MooseX::Declare;

class Gitalist::Git::Object::Blob extends Gitalist::Git::Object {
  use MooseX::Types::Common::String qw/NonEmptySimpleStr/;

  has '+type' => ( default => 'blob' );
}
