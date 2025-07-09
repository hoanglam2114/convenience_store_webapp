<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create New Blog Post</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            .editor-toolbar {
                scrollbar-width: thin;
                scrollbar-color: #cbd5e0 #f1f5f9;
            }
            .editor-toolbar::-webkit-scrollbar {
                height: 6px;
            }
            .editor-toolbar::-webkit-scrollbar-track {
                background: #f1f5f9;
            }
            .editor-toolbar::-webkit-scrollbar-thumb {
                background-color: #cbd5e0;
                border-radius: 3px;
            }
            #content {
                min-height: 300px;
            }
            .tag-input:focus {
                outline: none;
                box-shadow: none;
            }
        </style>
    </head>
    <body class="bg-gray-50">
        <div class="max-w-5xl mx-auto px-4 py-8">
            <!-- Header -->
            <header class="mb-8">
                <h1 class="text-3xl font-bold text-indigo-700">Tạo Bài Đăng Mới</h1>
            </header>

            <!-- Post Form -->
            <div class="bg-white rounded-xl shadow-md overflow-hidden">
                <!-- Form Header -->
                <div class="bg-indigo-50 px-6 py-4 border-b border-gray-200">
                    <div class="flex items-center justify-between">
                        <h2 class="text-lg font-semibold text-indigo-800">Chi tiết bài đăng</h2>
                        <div class="flex space-x-2">
                            <button id="previewBtn" class="px-3 py-1.5 text-sm bg-white border border-indigo-300 text-indigo-600 rounded-md hover:bg-indigo-50 transition">
                                <i class="fas fa-eye mr-1"></i> Preview
                            </button>
                            <button id="saveDraftBtn" class="px-3 py-1.5 text-sm bg-indigo-100 text-indigo-700 rounded-md hover:bg-indigo-200 transition">
                                <i class="fas fa-save mr-1"></i> Save Draft
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Main Form Content -->
                <form id="postForm" class="p-6" action="${pageContext.request.contextPath}/customer-create-post" method="post" enctype="multipart/form-data">
                    
                    <!-- Title Input -->
                    <div class="mb-6">
                        <label for="title" class="block text-sm font-medium text-gray-700 mb-1">Chủ Đề</label>
                        <input type="text" id="title" name="title" 
                               class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 text-base outline-none transition"
                               placeholder="Thêm chủ đề..." required>
                    </div>

                    <!-- Featured Image Upload -->
                    <div class="mb-6">
                        <label class="block text-sm font-medium text-gray-700 mb-1">Ảnh</label>
                        <div class="mt-1 flex justify-center px-6 pt-5 pb-6 border-2 border-gray-300 border-dashed rounded-lg">
                            <div class="space-y-1 text-center">
                                <div class="flex justify-center text-gray-400">
                                    <svg class="mx-auto h-12 w-12" stroke="currentColor" fill="none" viewBox="0 0 48 48" aria-hidden="true">
                                    <path d="M28 8H12a4 4 0 00-4 4v20m32-12v8m0 0v8a4 4 0 01-4 4H12a4 4 0 01-4-4v-4m32-4l-3.172-3.172a4 4 0 00-5.656 0L28 28M8 32l9.172-9.172a4 4 0 015.656 0L28 28m0 0l4 4m4-24h8m-4-4v8m-12 4h.02" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                                    </svg>
                                </div>
                                <div class="flex text-sm text-gray-600">
                                    <label for="featuredImage" class="relative cursor-pointer bg-white rounded-md font-medium text-indigo-600 hover:text-indigo-500 focus-within:outline-none">
                                        <span>Đăng một ảnh</span>
                                        <input id="featuredImage" name="featuredImage" type="file" class="sr-only" accept="image/*">
                                    </label>
                                    <p class="pl-1">hoặc kéo thả</p>
                                </div>
                                <p class="text-xs text-gray-500">PNG, JPG, GIF lên tới 5MB</p>
                            </div>
                        </div>
                    </div>

                    <!-- Content Editor -->
                    <div class="mb-6">
                        <label for="content" class="block text-sm font-medium text-gray-700 mb-1">Nội Dung</label>

                        <!-- Editor Toolbar -->
                        <div class="editor-toolbar mb-2 flex items-center space-x-1 overflow-x-auto p-1 bg-gray-50 rounded-lg">
                            <button type="button" class="p-2 rounded hover:bg-gray-200" title="Bold" data-command="bold">
                                <i class="fas fa-bold"></i>
                            </button>
                            <button type="button" class="p-2 rounded hover:bg-gray-200" title="Italic" data-command="italic">
                                <i class="fas fa-italic"></i>
                            </button>
                            <button type="button" class="p-2 rounded hover:bg-gray-200" title="Heading 1" data-command="h1">
                                <i class="fas fa-heading"></i>
                            </button>
                            <button type="button" class="p-2 rounded hover:bg-gray-200" title="Quote" data-command="quote">
                                <i class="fas fa-quote-right"></i>
                            </button>
                            <button type="button" class="p-2 rounded hover:bg-gray-200" title="Link" data-command="link">
                                <i class="fas fa-link"></i>
                            </button>
                            <button type="button" class="p-2 rounded hover:bg-gray-200" title="Image" data-command="image">
                                <i class="fas fa-image"></i>
                            </button>
                            <button type="button" class="p-2 rounded hover:bg-gray-200" title="List" data-command="ul">
                                <i class="fas fa-list-ul"></i>
                            </button>
                            <button type="button" class="p-2 rounded hover:bg-gray-200" title="Numbered List" data-command="ol">
                                <i class="fas fa-list-ol"></i>
                            </button>
                            <button type="button" class="p-2 rounded hover:bg-gray-200" title="Code" data-command="code">
                                <i class="fas fa-code"></i>
                            </button>
                            <button type="button" class="p-2 rounded hover:bg-gray-200" title="Preview" data-command="preview">
                                <i class="fas fa-eye"></i>
                            </button>
                            <button type="button" class="p-2 rounded hover:bg-gray-200" title="Fullscreen" data-command="fullscreen">
                                <i class="fas fa-expand"></i>
                            </button>
                        </div>

                        <!-- Editor Content -->
                        <div id="content" class="w-full px-4 py-3 rounded-lg border border-gray-300 min-h-[300px] focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 text-base outline-none transition" 
                             contenteditable="true" placeholder="Write your post content here..."></div>
                    </div>

                    <!-- Tags Input -->
                    <div class="mb-6">
                        <label for="tags" class="block text-sm font-medium text-gray-700 mb-1">Danh Mục</label>
                        <div class="flex flex-wrap items-center gap-2 px-3 py-2 border border-gray-300 rounded-lg focus-within:border-indigo-500 focus-within:ring-2 focus-within:ring-indigo-200">
                            <div id="tagContainer" class="flex flex-wrap gap-2"></div>
                            <input type="text" id="tagInput" class="tag-input flex-1 min-w-[100px] border-none focus:ring-0 px-1 py-1" placeholder="Thêm danh mục...">
                        </div>
                    </div>

                    <!-- SEO Section -->
                    <div class="mb-6">
                        <label class="block text-sm font-medium text-gray-700 mb-1">SEO Settings</label>
                        <div class="mt-1 space-y-4">
                            <div>
                                <label for="metaTitle" class="block text-xs font-medium text-gray-500 mb-1">Meta Title</label>
                                <input type="text" id="metaTitle" name="metaTitle" 
                                       class="w-full px-3 py-2 rounded-md border border-gray-300 focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 text-sm outline-none transition"
                                       placeholder="Title for search engines">
                            </div>
                            <div>
                                <label for="metaDescription" class="block text-xs font-medium text-gray-500 mb-1">Meta Description</label>
                                <textarea id="metaDescription" name="metaDescription" rows="2"
                                          class="w-full px-3 py-2 rounded-md border border-gray-300 focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 text-sm outline-none transition"
                                          placeholder="Brief description for search results"></textarea>
                            </div>
                        </div>
                    </div>

                    <!-- Publish Options -->
                    <div class="mb-6">
                        <label class="block text-sm font-medium text-gray-700 mb-3">Publish Options</label>
                        <div class="space-y-3">
                            <div class="flex items-center">
                                <input id="publishNow" name="publishOption" type="radio" checked 
                                       class="h-4 w-4 text-indigo-600 focus:ring-indigo-500 border-gray-300">
                                <label for="publishNow" class="ml-2 block text-sm text-gray-700">Publish immediately</label>
                            </div>
                            <div class="flex items-center">
                                <input id="schedulePublish" name="publishOption" type="radio" 
                                       class="h-4 w-4 text-indigo-600 focus:ring-indigo-500 border-gray-300">
                                <label for="schedulePublish" class="ml-2 block text-sm text-gray-700">Schedule for later</label>
                                <input type="datetime-local" id="publishDate" name="publishDate" 
                                       class="ml-3 px-2 py-1 border border-gray-300 rounded-md text-sm disabled:opacity-50 disabled:bg-gray-100" disabled>
                            </div>
                        </div>
                    </div>

                    <!-- Form Actions -->
                    <div class="flex flex-col sm:flex-row justify-end gap-3 pt-4 border-t border-gray-200">
                        <button type="button" class="px-4 py-2 border border-gray-300 rounded-md text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                            Huỷ
                        </button>
                        <input type="hidden" name="tags[]" id="tagsHiddenInput">
                        <button type="submit" class="px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                            Đăng
                        </button>
                    </div>
                </form>
            </div>

            <!-- Preview Modal (hidden by default) -->
            <div id="previewModal" class="fixed inset-0 z-50 hidden overflow-y-auto">
                <div class="flex items-center justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
                    <div class="fixed inset-0 transition-opacity" aria-hidden="true">
                        <div class="absolute inset-0 bg-gray-500 opacity-75"></div>
                    </div>
                    <span class="hidden sm:inline-block sm:align-middle sm:h-screen" aria-hidden="true">&#8203;</span>
                    <div class="inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-4xl sm:w-full">
                        <div class="bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
                            <div class="sm:flex sm:items-start">
                                <div class="mt-3 text-center sm:mt-0 sm:ml-4 sm:text-left w-full">
                                    <h3 class="text-lg leading-6 font-medium text-gray-900 mb-4">Post Preview</h3>
                                    <div id="previewContent" class="prose max-w-none">
                                        <!-- Preview content will be inserted here -->
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="bg-gray-50 px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse">
                            <button type="button" id="closePreview" class="mt-3 w-full inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 sm:mt-0 sm:ml-3 sm:w-auto sm:text-sm">
                                Close
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Tags functionality
                const tagInput = document.getElementById('tagInput');
                const tagContainer = document.getElementById('tagContainer');
                let tags = [];

                tagInput.addEventListener('keydown', function (e) {
                    if ((e.key === 'Enter' || e.key === ',') && tagInput.value.trim() !== '') {
                        e.preventDefault();
                        const tagText = tagInput.value.trim().replace(',', '');
                        if (tagText !== '' && !tags.includes(tagText)) {
                            tags.push(tagText);
                            renderTags();
                            tagInput.value = '';
                        }
                    }
                });

                function renderTags() {
                    tagContainer.innerHTML = '';
                    tags.forEach((tag, index) => {
                        const tagElement = document.createElement('div');
                        tagElement.className = 'flex items-center bg-indigo-100 text-indigo-800 px-3 py-1 rounded-full text-sm';
                        tagElement.innerHTML = `
            ${tag}
                            <button type="button" data-index="${index}" class="ml-1.5 text-indigo-600 hover:text-indigo-900">
                                <i class="fas fa-times text-xs"></i>
                            </button>
                        `;
                        tagContainer.appendChild(tagElement);
                    });

                    // Add event listeners to remove buttons
                    document.querySelectorAll('#tagContainer button').forEach(button => {
                        button.addEventListener('click', function () {
                            const index = parseInt(this.getAttribute('data-index'));
                            tags.splice(index, 1);
                            renderTags();
                        });
                    });
                }

                // Publish options toggle
                const publishNow = document.getElementById('publishNow');
                const schedulePublish = document.getElementById('schedulePublish');
                const publishDate = document.getElementById('publishDate');

                publishNow.addEventListener('change', function () {
                    publishDate.disabled = true;
                });

                schedulePublish.addEventListener('change', function () {
                    publishDate.disabled = false;
                });

                // Editor toolbar functionality
                document.querySelectorAll('.editor-toolbar button').forEach(button => {
                    button.addEventListener('click', function () {
                        const command = this.getAttribute('data-command');
                        execCommand(command);
                    });
                });

                function execCommand(command) {
                    const contentEditable = document.getElementById('content');

                    if (command === 'h1') {
                        document.execCommand('formatBlock', false, '<h1>');
                    } else if (command === 'preview') {
                        showPreview();
                    } else if (command === 'fullscreen') {
                        toggleFullscreen();
                    } else {
                        document.execCommand(command, false, null);
                    }
                    contentEditable.focus();
                }

                // Preview functionality
                const previewBtn = document.getElementById('previewBtn');
                const previewModal = document.getElementById('previewModal');
                const closePreview = document.getElementById('closePreview');
                const previewContent = document.getElementById('previewContent');

                previewBtn.addEventListener('click', showPreview);
                closePreview.addEventListener('click', function () {
                    previewModal.classList.add('hidden');
                });

                function showPreview() {
                    const title = document.getElementById('title').value || 'Untitled Post';
                    const content = document.getElementById('content').innerHTML;

                    previewContent.innerHTML = `
                        <h1 class="text-3xl font-bold mb-4">${title}</h1>
                        <div>${content}</div>
                    `;

                    previewModal.classList.remove('hidden');
                }

                // Form submission
                const postForm = document.getElementById('postForm');

                postForm.addEventListener('submit', function (e) {
                    e.preventDefault();

                    // Get form values
                    const title = document.getElementById('title').value;
                    const content = document.getElementById('content').innerHTML;
                    const publishOption = document.querySelector('input[name="publishOption"]:checked').value;
                    const publishDateValue = publishOption === 'schedulePublish' ? document.getElementById('publishDate').value : null;
                    
                    document.getElementById('tagsHiddenInput').value = tags.join(',');
                    
                    // In a real app, you would send this data to your server
                    console.log('Post submitted:', {
                        title,
                        content,
                        tags,
                        publishOption,
                        publishDate: publishDateValue
                    });

                    postForm.submit();
                });

                // Fullscreen editor toggle
                function toggleFullscreen() {
                    const editor = document.getElementById('content');
                    if (!document.fullscreenElement) {
                        editor.requestFullscreen().catch(err => {
                            console.error(`Error attempting to enable fullscreen: ${err.message}`);
                        });
                    } else {
                        document.exitFullscreen();
                    }
                }
            });
        </script>
    </body>
</html>