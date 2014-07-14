require 'spec_helper'

describe Ckeditor::Picture do
  describe ".find_associated_pictures" do
    let(:sql) { double("sql") }
    let(:join_sql) { "JOIN blog_imageables ON blog_imageables.ckeditor_assets_id = ckeditor_assets.id" }
    let(:model_name) { BlogPost }
    let(:model_id) { 100 }
    let(:id) { 100 }

    before :each do
      allow(Ckeditor::Picture).to receive(:joins).with(join_sql).and_return sql
      allow(sql).to receive(:where).
        with("blog_imageables.imageable_type = ? AND blog_imageables.imageable_id = ?", model_name, model_id).and_return sql
    end

    it "searches for pictures associated by model name and model id " do
      expect(sql).to receive(:where).
        with("blog_imageables.imageable_type = ? AND blog_imageables.imageable_id = ?", model_name, model_id)

      Ckeditor::Picture.find_associated_pictures(model_name, model_id)
    end

    it "returns the picture with the specified id" do
      allow(sql).to receive(:first)
      expect(sql).to receive(:where).
        with("ckeditor_assets.id = ?", id).and_return sql

      Ckeditor::Picture.find_associated_pictures(model_name, model_id, id)
    end
  end
end
