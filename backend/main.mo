import Nat "mo:base/Nat";
import Text "mo:base/Text";

import Array "mo:base/Array";
import Time "mo:base/Time";
import List "mo:base/List";
import Int "mo:base/Int";

actor {
  type Post = {
    id: Nat;
    title: Text;
    body: Text;
    author: Text;
    timestamp: Int;
  };

  stable var postId: Nat = 0;
  stable var posts: [Post] = [];

  public query func getPosts() : async [Post] {
    Array.sort(posts, func(a: Post, b: Post) : { #less; #equal; #greater } {
      Int.compare(b.timestamp, a.timestamp)
    })
  };

  public func createPost(title: Text, body: Text, author: Text) : async Nat {
    let timestamp = Time.now();
    let post: Post = {
      id = postId;
      title;
      body;
      author;
      timestamp;
    };
    posts := Array.append(posts, [post]);
    postId += 1;
    postId - 1
  };
}
