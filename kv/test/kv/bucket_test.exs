defmodule KV.BucketTest do
    use ExUnit.Case, async: true

    setup do
        {:ok, bucket} = KV.Bucket.start_link
        {:ok, bucket: bucket}
    end

    test "stores values by key", %{bucket: bucket} do
        # `bucket` is now defined in the setup block
        assert KV.Bucket.get(bucket, "milk") == nil

        KV.Bucket.put(bucket, "milk", 3)
        assert KV.Bucket.get(bucket, "milk") == 3
    end

    test "deletes existing keys and returns their value", %{bucket: bucket} do
        KV.Bucket.put(bucket, "milk", 3)
        assert KV.Bucket.delete(bucket, "milk") == 3
        assert KV.Bucket.get(bucket, "milk") == nil
    end

    test "does not delete non-existent keys", %{bucket: bucket} do
        KV.Bucket.put(bucket, "milk", 3)
        assert KV.Bucket.delete(bucket, "cheese") == nil
        assert KV.Bucket.get(bucket, "milk") == 3
    end
end
