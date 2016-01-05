defmodule KV.BucketTest do
    use ExUnit.Case, async: true

    setup do
        {:ok, bucket} = KV.Bucket.start_link
        {:ok, bucket: bucket}
    end

    test "stores values by key", %{bucket: bucket} do
        assert KV.Bucket.get(bucket, "milk") == nil

        KV.Bucket.put(bucket, "milk", 3)
        assert KV.Bucket.get(bucket, "milk") == 3
    end

    test "deletes keys", %{bucket: bucket} do
        KV.Bucket.put(bucket, "cheese", 5)

        assert KV.Bucket.delete(bucket, "cheese") == 5
        assert KV.Bucket.get(bucket, "cheese") == nil
    end
end
