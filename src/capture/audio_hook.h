/**
 * \file src/capture/audio_hook.h
 * \brief audio capture
 * \author Pyry Haulos <pyry.haulos@gmail.com>
 * \date 2007
 */

/* audio_hook.h -- audio capture
 * Copyright (C) 2007 Pyry Haulos
 * For conditions of distribution and use, see copyright notice in glc.h
 */

#ifndef _AUDIO_HOOK_H
#define _AUDIO_HOOK_H

#include <packetstream.h>
#include <alsa/asoundlib.h>
#include "../common/glc.h"

/**
 * \addtogroup audio_hook
 *  \{
 */

__PUBLIC void *audio_hook_init(glc_t *glc, ps_buffer_t *to);
__PUBLIC int audio_hook_close(void *audiopriv);

__PUBLIC int audio_hook_alsa_i(void *audiopriv, snd_pcm_t *pcm, const void *buffer, snd_pcm_uframes_t size);
__PUBLIC int audio_hook_alsa_n(void *audiopriv, snd_pcm_t *pcm, void **bufs, snd_pcm_uframes_t size);

__PUBLIC int audio_hook_alsa_mmap_begin(void *audiopriv, snd_pcm_t *pcm, const snd_pcm_channel_area_t *areas);
__PUBLIC int audio_hook_alsa_mmap_commit(void *audiopriv, snd_pcm_t *pcm, snd_pcm_uframes_t offset, snd_pcm_uframes_t frames);

#endif

/**  \} */