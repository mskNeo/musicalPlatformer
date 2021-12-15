import pygame
from pygame.locals import *
import sys
import random
import client

pygame.init()
vec = pygame.math.Vector2

WIDTH = 1000
HEIGHT = int(WIDTH * 0.8)
ACC = 0.5
FRIC = -0.12
FPS = 60

FramePerSec = pygame.time.Clock()

screen = pygame.display.set_mode((WIDTH, HEIGHT))
pygame.display.set_caption("CPSC 431: Musical Platformer")


class Player(pygame.sprite.Sprite):
    def __init__(self):
        super().__init__() 
        self.platformsHit = 0
        self.onPlatform = False
        self.surf = pygame.Surface((30, 30))
        self.surf.fill((0, 0, 255))
        self.rect = self.surf.get_rect(center = (10, HEIGHT - 25))
        self.start_x = 10
        self.start_y = HEIGHT - 25

        self.pos = vec((10, HEIGHT - 45))
        self.vel = vec(0,0)
        self.acc = vec(0,0)
    
    def move(self):
        self.acc = vec(0,0.5)

        pressed_keys = pygame.key.get_pressed()
                
        if pressed_keys[K_LEFT]:
            self.acc.x = -ACC
        if pressed_keys[K_RIGHT]:
            self.acc.x = ACC   

        self.acc.x += self.vel.x * FRIC
        self.vel += self.acc
        self.pos += self.vel + 0.5 * self.acc

        if self.pos.x > WIDTH:
            self.pos.x = 0
        if self.pos.x < 0:
            self.pos.x = WIDTH
            
        self.rect.midbottom = self.pos

    def jump(self):
        hits = pygame.sprite.spritecollide(self, platforms, False)
        if hits:
            self.vel.y = -15
            self.onPlatform = False

    def update(self):
        hits = pygame.sprite.spritecollide(self, platforms, False)
        if P1.vel.y > 0:        
            if hits:
                self.vel.y = 0
                self.pos.y = hits[0].rect.top + 1
                if (not hits[0].floor):
                    hits[0].surf.fill((0, 0, 255))
                    if (not self.onPlatform):
                        client.hitPlatform(self.platformsHit) 
                        self.platformsHit = self.platformsHit + 1
                        self.onPlatform = True

        # remake map when get to goal
        goalHits = pygame.sprite.spritecollide(self, items, False)
        if goalHits:
            client.hitGoal()    # send message to play chord here
            self.platformsHit = 0
            P1.rect.x = P1.start_x
            P1.rect.y = P1.start_y
            P1.pos = vec((P1.start_x, P1.start_y ))
            platforms.empty()
            platforms.add(PT1)
            generatePlatforms()


class platform(pygame.sprite.Sprite):
    def __init__(self):
        super().__init__()
        self.floor = False
        self.surf = pygame.Surface((random.randint(300, 500), 8))
        self.surf.fill((0, 255, 0))
        self.rect = self.surf.get_rect(center = (random.randint(0, WIDTH - 10), random.randint(0, HEIGHT - 30)))

    def move(self):
        pass

class item(pygame.sprite.Sprite):
    def __init__(self):
        super().__init__()
        self.surf = pygame.Surface((15, 15))
        self.surf.fill((255, 255, 255))
        self.rect = self.surf.get_rect(center = (50, 50))

    def move(self):
        pass

def generatePlatforms():
    items.add(GOAL)
    numPlats = 5
    sections = [x for x in range(numPlats)]
    xSection = random.choice(sections)

    for x in sections:
        pl = platform()
        pl.rect = pl.surf.get_rect(center = (xSection * WIDTH / numPlats + random.randint(-30, 30), x * HEIGHT / numPlats + random.randint(50, 80)))
        platforms.add(pl)

        if (x == 0):
            GOAL.rect = GOAL.surf.get_rect(center = (pl.rect[0] + pl.rect[2] / 2, pl.rect[1] - 20))

        if (xSection == 0):
            xSection = random.randint(xSection + 1, xSection + 2)
        elif (xSection == numPlats):
            xSection = random.randint(xSection - 2, xSection - 1)
        else:
            xSection = random.randint(xSection - 1, xSection + 1)


# player and platforms
PT1 = platform()
PT1.floor = True
PT1.surf = pygame.Surface((WIDTH, 20))
PT1.surf.fill((255,0,0))
PT1.rect = PT1.surf.get_rect(center = (WIDTH / 2, HEIGHT - 10))

GOAL = item()
P1 = Player()

all_sprites = pygame.sprite.Group()
all_sprites.add(PT1)
all_sprites.add(P1)
all_sprites.add(GOAL)

platforms = pygame.sprite.Group()
platforms.add(PT1)

items = pygame.sprite.Group()

generatePlatforms()

while True: 
    for event in pygame.event.get():
        if event.type == QUIT:
            pygame.quit()
            sys.exit()
        if event.type == pygame.KEYDOWN:    
            if event.key == pygame.K_SPACE:
                P1.jump()

    screen.fill((0,0,0))
    P1.update()

    for entity in all_sprites:
        screen.blit(entity.surf, entity.rect)
        entity.move()

    for plat in platforms:
        screen.blit(plat.surf, plat.rect)
        plat.move()

    pygame.display.update()
    FramePerSec.tick(FPS)


