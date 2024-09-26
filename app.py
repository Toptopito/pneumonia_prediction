import gradio as gr

from fastai.vision.all import *


# Setup test mode or not
test = True

# load model
if test:
    learn = load_learner('test_model.pkl')
else:
    learn = load_learner('model.pkl')


categories = ('CLEAR', 'PNEUMONIA')

def classify_image(img):
    pred, idx, probs = learn.predict(img)
    return dict(zip(categories, map(float, probs)))

examples = ['./unseen_data/NORMAL/NORMAL2-IM-1427-0001.jpeg', 
            './unseen_data/PNEUMONIA/person1946_bacteria_4874.jpeg',
            './unseen_data/NORMAL/NORMAL2-IM-1430-0001.jpeg',
            './unseen_data/PNEUMONIA/person1946_bacteria_4875.jpeg']

title = 'Chest X-Ray Classifier'

description = """An X-Ray classifier trained on the Labeled Optical Coherence Tomography (OCT) and Chest X-Ray Images for Classification dataset with fastai. 
License: CC BY 4.0
Citation: http://www.cell.com/cell/fulltext/S0092-8674(18)30154-5"""

article="<p style='text-align: center'><a href='https://www.kaggle.com/datasets/paultimothymooney/chest-xray-pneumonia' target='_blank'>Kaggle Dataset</a></p>"

intf = gr.Interface(fn=classify_image, 
                    inputs=gr.Image(type='pil'), 
                    outputs=gr.Label(), 
                    examples=examples,
                    title = title,
                    description = description,
                    article = article)

intf.launch(inline=False, share=True)