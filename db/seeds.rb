AdminUser.create!([
  {email: "admin@example.com", password: "password", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 5, current_sign_in_at: "2017-06-26 16:28:13", last_sign_in_at: "2017-06-13 23:02:45", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1"}
])
Component.create!([
  {name: "Story Time", position: 3, lesson_id: 3, componentable_id: 9, componentable_type: "Video", slug: "story-time"},
  {name: "Tutoring Notes 1", position: 2, lesson_id: 4, componentable_id: 16, componentable_type: "Video", slug: "tutoring-notes-1"},
  {name: "Tutoring Notes 2", position: 3, lesson_id: 4, componentable_id: 17, componentable_type: "Video", slug: "tutoring-notes-2"},
  {name: "Tutoring Notes 3", position: 4, lesson_id: 4, componentable_id: 18, componentable_type: "Video", slug: "tutoring-notes-3"},
  {name: "Tutoring Notes 4", position: 5, lesson_id: 4, componentable_id: 19, componentable_type: "Video", slug: "tutoring-notes-4"},
  {name: "Tutoring Notes 5", position: 6, lesson_id: 4, componentable_id: 20, componentable_type: "Video", slug: "tutoring-notes-5"},
  {name: "Chat video 1", position: 7, lesson_id: 6, componentable_id: 21, componentable_type: "Video", slug: "chat-video-1"},
  {name: "Chat video 2", position: 9, lesson_id: 6, componentable_id: 22, componentable_type: "Video", slug: "chat-video-2"},
  {name: "Chat recording 1", position: 8, lesson_id: 6, componentable_id: 1, componentable_type: "RecordingList", slug: "chat-recording-1"},
  {name: "Chat recording 2", position: 10, lesson_id: 6, componentable_id: 2, componentable_type: "RecordingList", slug: "chat-recording-2"},
  {name: "Scene 1", position: 11, lesson_id: 5, componentable_id: 25, componentable_type: "Video", slug: "scene-1"}
])
Course.create!([
  {name: "CHIN 10153: Beginning Chinese I", content: "This is an introductory Chinese course for students with no or little prior experience in standard Mandarin.", image_file_name: "New-Photo2-1024x623.jpg", image_content_type: "image/jpeg", image_file_size: 163839, image_updated_at: "2017-06-01 04:56:58", slug: "test-course"},
  {name: "CHIN 20053: Intermediate Chinese I", content: "CHIN 20053 will develop listening, speaking, reading, and writing skills at the intermediate level.", image_file_name: "BrEd9qYCIAEpwaQ.jpg", image_content_type: "image/jpeg", image_file_size: 68622, image_updated_at: "2017-06-01 04:57:37", slug: "chin-20053-intermediate-chinese-i"},
  {name: "CHIN 30063: Intermediate Chinese IV", content: "CHIN 30063 continues to develop speaking, listening, reading, and writing skills at the intermediate-high level.", image_file_name: "harris.jpg", image_content_type: "image/jpeg", image_file_size: 152558, image_updated_at: "2017-06-01 04:58:11", slug: "chin-30063-intermediate-chinese-iv"}
])
Lesson.create!([
  {title: "Lesson 1", note: "", header: true, position: 1, course_id: 1, slug: "story-time"},
  {title: "Story Time", note: "", header: false, position: 2, course_id: 1, slug: "story-time-85951f63-2c45-4d73-aa6d-6d6298ad5a8c"},
  {title: "Tutoring Notes", note: "", header: false, position: 3, course_id: 1, slug: "tutoring-notes"},
  {title: "Scene Related Questions", note: "", header: false, position: 4, course_id: 1, slug: "scene-related-questions"},
  {title: "Let's Chat", note: "", header: false, position: 5, course_id: 1, slug: "let-s-chat"},
  {title: "Lesson 2", note: "", header: true, position: 6, course_id: 1, slug: "lesson-2"},
  {title: "Story Time", note: "", header: false, position: 7, course_id: 1, slug: "story-time-e31c80c4-93cd-4799-b8ef-eda4f888584a"},
  {title: "Tutoring Notes", note: "", header: false, position: 8, course_id: 1, slug: "tutoring-notes-74d1930f-dd28-4f4b-8ad5-5878033ebb6d"},
  {title: "Scene Related Questions", note: "", header: false, position: 9, course_id: 1, slug: "scene-related-questions-c7c45bc1-bed1-4016-953e-356959fe5c5d"},
  {title: "Let's Chat", note: "", header: false, position: 10, course_id: 1, slug: "let-s-chat-8b6d917a-da5b-4332-a85c-b04660d7b932"},
  {title: "Lesson 1", note: "", header: true, position: 11, course_id: 2, slug: "lesson-2-27a57c63-ab02-4bba-99b1-6c7a54fa046d"},
  {title: "Story Time", note: "", header: false, position: 12, course_id: 2, slug: "story-time-5ec0e47c-5a43-4b20-9ed9-c39415deab41"},
  {title: "Scene Related Questions", note: "", header: false, position: 13, course_id: 2, slug: "scene-related-questions-cb51eae9-eef3-4915-aa48-0b49cac4c355"},
  {title: "Let's Chat", note: "", header: false, position: 14, course_id: 2, slug: "let-s-chat-4aaa71e0-8188-4087-8254-052899d995c1"},
  {title: "Lesson 1", note: "", header: true, position: 15, course_id: 3, slug: "lesson-1"}
])
User.create!([
  {email: "test@example.com", password: "password", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 8, current_sign_in_at: "2017-06-13 22:41:38", last_sign_in_at: "2017-06-08 05:26:18", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", first_name: "John", last_name: "Doe", username: "test"},
  {email: "test1@example.com", password: "password", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 2, current_sign_in_at: "2017-06-26 16:32:20", last_sign_in_at: "2017-06-14 04:00:59", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", first_name: "test2", last_name: "John", username: "N"}
])
Caption.create!([
  {video_id: 9, file_file_name: "simplified-characters.vtt", file_content_type: "application/octet-stream", file_file_size: 1570, file_updated_at: "2017-06-01 05:35:35"},
  {video_id: 9, file_file_name: "pinyin.vtt", file_content_type: "application/octet-stream", file_file_size: 1641, file_updated_at: "2017-06-01 05:35:35"},
  {video_id: 9, file_file_name: "English.vtt", file_content_type: "application/octet-stream", file_file_size: 1605, file_updated_at: "2017-06-01 05:35:35"}
])
Enrollment.create!([
  {course_id: 1, user_id: 1},
  {course_id: 1, user_id: 2}
])
RecordingList.create!([
  {limit: 3},
  {limit: 5}
])
Recording.create!([
  {url: "54da38c5-9920-41a3-83da-ca06d9323d78/2017-06-14T03:45:17.099Z.wav", user_id: 1, recording_list_id: 1, submitted: true},
  {url: "ff079c9c-a855-4ed8-b0c3-118b0335622d/2017-06-14T03:45:30.030Z.wav", user_id: 1, recording_list_id: 1, submitted: false},
  {url: "2c29ca94-df1b-4b7c-a0e5-5b778d7eb6f4/2017-06-14T03:45:39.816Z.wav", user_id: 1, recording_list_id: 1, submitted: false},
  {url: "f1784260-36a6-4730-9730-44fa02f8f83c/2017-06-14T03:54:56.800Z.wav", user_id: 1, recording_list_id: 2, submitted: true},
  {url: "46115e44-3f01-4a39-baba-21047daa99f8/2017-06-26T16:32:49.296Z.wav", user_id: 2, recording_list_id: 1, submitted: false}
])
Video.create!([
  {url: "https://s3.amazonaws.com/chinese-clips/lessons/lesson1/clip1.mp4"},
  {url: "https://s3.amazonaws.com/chinese-clips/tutoring-notes/Tutoring+Note+Part+1.mp4"},
  {url: "https://s3.amazonaws.com/chinese-clips/tutoring-notes/Tutoring+Note+Part+2.mp4"},
  {url: "https://s3.amazonaws.com/chinese-clips/tutoring-notes/Tutoring+Note+Part+3.mp4"},
  {url: "https://s3.amazonaws.com/chinese-clips/tutoring-notes/Tutoring+Note+Part+4.mp4"},
  {url: "https://s3.amazonaws.com/chinese-clips/tutoring-notes/Tutoring+Note+Part+5.mp4"},
  {url: "https://s3.amazonaws.com/chinese-clips/tutoring-notes/Tutoring+Note+Part+1.mp4"},
  {url: "https://s3.amazonaws.com/chinese-clips/tutoring-notes/Tutoring+Note+Part+2.mp4"},
  {url: "1"}
])
